// ginkgo_battery.asl - Bateria REAL para Redmi Note 8 (ginkgo), solo lectura
//
// Pegala DENTRO de Scope (\_SB) de tu DSDT/SSDT, REEMPLAZANDO el bloque de
// bateria falsa anterior (BAT0 / ADP1). Si en tu DSDT se llaman distinto,
// borra los dos dispositivos anteriores (PNP0C0A y ACPI0003) para no duplicar.
//
// Lee el PMIC por el canal OBSERVADOR del arbitro SPMI v5 (solo lectura):
//   obsrvr = 0x03E00000, canal = 0x80 * APID (ee = 0)
//   APID 139 = smb5 chgr (PPID 0x210)   -> 0x4580
//   APID 142 = smb5 usb  (PPID 0x213)   -> 0x4700
//   APID 156 = qg        (PPID 0x248)   -> 0x4E00
//   (APID 140 = smb5 dcdc -> 0x4600, reservado)
// Esos APID salen de tu spmi_log.txt (tabla v5, write_ee 0).
//
// Registros usados (todos de lectura):
//   QG 0x4808 STATUS1 (bit0 bateria presente, bit7 QG_OK)
//   QG 0x48C0 LAST_ADC_V   (16 bit)  mV = raw * 0.194637
//   QG 0x48C2 LAST_ADC_I (16 bit con signo, promedio de 4 lecturas) mA = raw * 0.152588
//        signo QG: positivo = descarga, negativo = carga
//   CHGR 0x1006 STATUS_1 [2:0]: 0 inhibit 1 trickle 2 pre 3 fullon 4 taper
//                               5 terminate 6 pause 7 disable
//   USBIN 0x1310 INT_RT_STS bit4 = cable conectado
//
// Constantes a ajustar mas abajo: RBMO (resistencia interna en mOhm), FULL,
// DESG. La tabla OCVT ya es la real del perfil light_4000mah (25 C).

Device (BAT0)
{
    Name (_HID, EisaId ("PNP0C0A"))
    Name (_UID, 0)
    Name (_PCL, Package () { \_SB })

    Method (_STA, 0, NotSerialized)
    {
        Return (0x1F)
    }

    // ---------------- acceso al arbitro SPMI (solo lectura) ----------------
    OperationRegion (SPMW, SystemMemory, 0x03E00000, 0x00010000)
    Field (SPMW, DWordAcc, NoLock, Preserve)
    {
        Offset (0x4580),
        CMDA, 32,           // APID 139 chgr
        Offset (0x4588),
        STSA, 32,
        Offset (0x4598),
        RDAA, 32,
        Offset (0x4700),
        CMDC, 32,           // APID 142 usb
        Offset (0x4708),
        STSC, 32,
        Offset (0x4718),
        RDAC, 32,
        Offset (0x4E00),
        CMDD, 32,           // APID 156 qg
        Offset (0x4E08),
        STSD, 32,
        Offset (0x4E18),
        RDAD, 32,
        Offset (0x5100),
        CMDE, 32,           // APID 162 qg sdam (PPID 0x2B1)
        Offset (0x5108),
        STSE, 32,
        Offset (0x5118),
        RDAE, 32
    }

    Mutex (SPMX, 0)
    Name (SPER, 0)          // 1 = fallo en alguna lectura SPMI

    // Lee Arg2 bytes (1..4) del registro Arg1 (0..0xFF) de la pagina Arg0
    //   Arg0: 0 = smb5 chgr, 2 = smb5 usb, 3 = qg
    // Debe llamarse con SPMX tomado.
    Method (SPRD, 3, NotSerialized)
    {
        // CMD = (EXT_READL=1 << 27) | (reg << 4) | (bytes - 1)
        Store (Or (0x08000000, Or (ShiftLeft (And (Arg1, 0xFF), 4), Subtract (Arg2, 1))), Local0)
        Store (Zero, Local1)    // dato
        Store (Zero, Local2)    // intentos
        Store (Zero, Local3)    // estado

        If (LEqual (Arg0, 0))
        {
            Store (Local0, CMDA)
            While (LLess (Local2, 100))
            {
                Store (STSA, Local3)
                If (And (Local3, 1))
                {
                    Break
                }
                Stall (2)
                Increment (Local2)
            }
            If (LEqual (And (Local3, 0xF), 1))
            {
                Store (RDAA, Local1)
            }
        }
        Else
        {
            If (LEqual (Arg0, 2))
            {
                Store (Local0, CMDC)
                While (LLess (Local2, 100))
                {
                    Store (STSC, Local3)
                    If (And (Local3, 1))
                    {
                        Break
                    }
                    Stall (2)
                    Increment (Local2)
                }
                If (LEqual (And (Local3, 0xF), 1))
                {
                    Store (RDAC, Local1)
                }
            }
            Else
            {
                Store (Local0, CMDD)
                While (LLess (Local2, 100))
                {
                    Store (STSD, Local3)
                    If (And (Local3, 1))
                    {
                        Break
                    }
                    Stall (2)
                    Increment (Local2)
                }
                If (LEqual (And (Local3, 0xF), 1))
                {
                    Store (RDAD, Local1)
                }
            }
        }

        // DONE sin FAILURE / DENIED / DROPPED  ->  (estado & 0xF) == 1
        If (LNotEqual (And (Local3, 0xF), 1))
        {
            Store (1, SPER)
            Return (Zero)
        }
        If (LLess (Arg2, 4))
        {
            Store (ShiftLeft (One, Multiply (Arg2, 8)), Local4)
            Decrement (Local4)
            And (Local1, Local4, Local1)
        }
        Return (Local1)
    }

    // Lee 1 byte del registro Arg0 del SDAM del QG (PMI632 0xB1xx). Con SPMX tomado.
    Method (SPRS, 1, NotSerialized)
    {
        Store (Or (0x08000000, ShiftLeft (And (Arg0, 0xFF), 4)), Local0)
        Store (Zero, Local2)
        Store (Zero, Local3)
        Store (Local0, CMDE)
        While (LLess (Local2, 100))
        {
            Store (STSE, Local3)
            If (And (Local3, 1))
            {
                Break
            }
            Stall (2)
            Increment (Local2)
        }
        If (LNotEqual (And (Local3, 0xF), 1))
        {
            Store (1, SPER)
            Return (Zero)
        }
        Store (RDAE, Local1)
        Return (And (Local1, 0xFF))
    }

    // ------------------------------ estado --------------------------------
    Name (USBP, 0)          // 1 = cable conectado
    Name (CHST, 0)          // estado del cargador (0..7)
    Name (VBMV, 0)          // tension de bateria, mV
    Name (IBMA, 0)          // corriente, mA (modulo)
    Name (IBNG, 0)          // 1 = corriente negativa (cargando)
    Name (SOCF, 0xFFFFFFFF) // % * 10 filtrado (0xFFFFFFFF = sin inicializar)
    Name (ISPS, 0)          // suma de corriente positiva (raw)
    Name (ISNS, 0)          // suma de corriente negativa (raw)
    Name (SOCP, 0xFFFFFFFF) // SOC en ppm (0..1000000); 0xFFFFFFFF = sin inicializar
    Name (LSTT, 0)          // Timer() de la ultima muestra (100 ns)
    Name (SERR, 1)
    // contadores de diagnostico: cuantas veces consulta Windows cada metodo
    Name (NBST, 0)
    Name (NBVC, 0)          // llamadas a _BST hechas por BATV (no cuentan)
    Name (NBIF, 0)
    Name (NPSR, 0)          // 1 = la ultima muestra fallo

    // ------------------- constantes ajustables ---------------------------
    Name (RBMO, 80)         // resistencia interna estimada, mOhm
    Name (FULL, 15338)      // capacidad llena en mWh (3984 mAh * 3.85 V)
    Name (DESG, 15400)      // capacidad de diseno en mWh (4000 mAh * 3.85 V)

    // Tabla OCV REAL a 25 C: qcom,light_4000mah / qcom,pc-temp-v1-lut
    // (columna de 25 C; pares mV, %, creciente en mV). 56 puntos.
    Name (OCVT, Package ()
    {
        3000, 0,
        3337, 1,
        3466, 2,
        3547, 3,
        3607, 4,
        3653, 5,
        3687, 6,
        3699, 7,
        3702, 8,
        3704, 9,
        3706, 10,
        3714, 12,
        3728, 14,
        3744, 16,
        3757, 18,
        3769, 20,
        3780, 22,
        3789, 24,
        3795, 26,
        3800, 28,
        3803, 30,
        3807, 32,
        3811, 34,
        3816, 36,
        3821, 38,
        3828, 40,
        3835, 42,
        3843, 44,
        3851, 46,
        3860, 48,
        3870, 50,
        3879, 52,
        3889, 54,
        3906, 56,
        3934, 58,
        3960, 60,
        3976, 62,
        3988, 64,
        4004, 66,
        4026, 68,
        4048, 70,
        4069, 72,
        4089, 74,
        4108, 76,
        4129, 78,
        4150, 80,
        4172, 82,
        4195, 84,
        4218, 86,
        4241, 88,
        4265, 90,
        4289, 92,
        4313, 94,
        4337, 96,
        4361, 98,
        4384, 100
    })

    // OCV (Arg0, mV) -> carga en 0.1 %
    Method (OCVS, 1, NotSerialized)
    {
        Store (SizeOf (OCVT), Local0)
        Store (DerefOf (Index (OCVT, 0)), Local2)
        If (LLessEqual (Arg0, Local2))
        {
            Return (0)
        }
        Store (DerefOf (Index (OCVT, Subtract (Local0, 2))), Local2)
        If (LGreaterEqual (Arg0, Local2))
        {
            Return (1000)
        }
        Store (2, Local1)
        While (LLess (Local1, Local0))
        {
            Store (DerefOf (Index (OCVT, Local1)), Local2)              // v1
            If (LLessEqual (Arg0, Local2))
            {
                Store (DerefOf (Index (OCVT, Subtract (Local1, 2))), Local3)   // v0
                Store (DerefOf (Index (OCVT, Subtract (Local1, 1))), Local4)   // p0
                Store (DerefOf (Index (OCVT, Add (Local1, 1))), Local5)        // p1
                Subtract (Local2, Local3, Local6)                              // dv
                Multiply (Subtract (Arg0, Local3), Subtract (Local5, Local4), Local7)
                Multiply (Local7, 10, Local7)
                Divide (Local7, Local6, Local1, Local7)
                Return (Add (Multiply (Local4, 10), Local7))
            }
            Add (Local1, 2, Local1)
        }
        Return (1000)
    }

    // Muestrea el PMIC y actualiza USBP, CHST, VBMV, IBMA, IBNG, SOCF, SERR
    Method (SMPL, 0, Serialized)
    {
        Acquire (SPMX, 0xFFFF)
        Store (Zero, SPER)

        Store (SPRD (2, 0x10, 1), Local0)       // USBIN INT_RT_STS
        Store (SPRD (0, 0x06, 1), Local1)       // CHGR STATUS_1
        Store (Zero, Local3)                    // suma de V (raw)
        Store (Zero, Local4)                    // muestras validas
        Store (Zero, Local5)                    // iteracion
        Store (Zero, ISPS)
        Store (Zero, ISNS)
        While (LLess (Local5, 4))
        {
            Store (SPRD (3, 0xC0, 2), Local6)   // QG LAST_ADC_V
            If (LAnd (LGreater (Local6, 0), LLess (Local6, 0x8000)))
            {
                Add (Local3, Local6, Local3)
                Increment (Local4)
            }
            // corriente instantanea QG LAST_ADC_I (0x8000 = sin dato)
            Store (SPRD (3, 0xC2, 2), Local7)
            If (LNotEqual (Local7, 0x8000))
            {
                If (And (Local7, 0x8000))
                {
                    Add (ISNS, Subtract (0x10000, Local7), ISNS)
                }
                Else
                {
                    Add (ISPS, Local7, ISPS)
                }
            }
            Sleep (1)
            Increment (Local5)
        }
        Release (SPMX)

        If (LOr (SPER, LEqual (Local4, 0)))
        {
            Store (1, SERR)
            Return (Zero)
        }
        Store (0, SERR)

        If (And (Local0, 0x10))
        {
            Store (1, USBP)
        }
        Else
        {
            Store (0, USBP)
        }
        And (Local1, 7, CHST)

        // tension en mV
        Divide (Local3, Local4, Local5, Local3)
        Divide (Multiply (Local3, 19464), 100000, Local5, VBMV)

        // corriente en mA: promedio de las muestras (positivo = descarga)
        If (LGreaterEqual (ISPS, ISNS))
        {
            Store (0, IBNG)
            Divide (Subtract (ISPS, ISNS), Local4, Local5, Local2)
        }
        Else
        {
            Store (1, IBNG)
            Divide (Subtract (ISNS, ISPS), Local4, Local5, Local2)
        }
        Divide (Multiply (Local2, 15259), 100000, Local5, IBMA)

        // tension en reposo estimada = V +/- I*R
        Divide (Multiply (IBMA, RBMO), 1000, Local5, Local6)
        If (IBNG)
        {
            If (LGreater (VBMV, Local6))
            {
                Subtract (VBMV, Local6, Local7)
            }
            Else
            {
                Store (VBMV, Local7)
            }
        }
        Else
        {
            Add (VBMV, Local6, Local7)
        }
        Store (OCVS (Local7), Local6)           // OCV: % * 10

        If (LEqual (SOCP, 0xFFFFFFFF))
        {
            // primera muestra: partir del SOC que dejo Android en el SDAM (0x47)
            // si es valido (0x46 = 1); si no, del OCV
            Acquire (SPMX, 0xFFFF)
            Store (Zero, SPER)
            Store (SPRS (0x46), Local1)
            Store (SPRS (0x47), Local2)
            Release (SPMX)
            If (LAnd (LEqual (SPER, 0), LAnd (LEqual (Local1, 1), LLessEqual (Local2, 100))))
            {
                Multiply (Local2, 10000, SOCP)
            }
            Else
            {
                Multiply (Local6, 1000, SOCP)
            }
            Store (Timer, LSTT)
        }
        Else
        {
            // conteo de carga: integra la corriente (ppm = mA * dt[100ns] / 143424000)
            Store (Timer, Local1)
            Subtract (Local1, LSTT, Local2)
            Store (Local1, LSTT)
            If (LGreater (Local2, 600000000))   // mas de 60 s sin medir: no integrar
            {
                Store (0, Local2)
            }
            Divide (Multiply (IBMA, Local2), 143424000, Local5, Local3)
            If (IBNG)
            {
                Add (SOCP, Local3, SOCP)
            }
            Else
            {
                If (LGreater (SOCP, Local3))
                {
                    Subtract (SOCP, Local3, SOCP)
                }
                Else
                {
                    Store (0, SOCP)
                }
            }

            // con poca corriente y sin cargador empujando el voltaje, el OCV es
            // fiable: acercarse con constante de tiempo ~300 s (depende de dt,
            // no del numero de consultas de Windows)
            If (LAnd (LLess (IBMA, 60), LOr (LEqual (USBP, 0), LGreaterEqual (CHST, 5))))
            {
                Multiply (Local6, 1000, Local4)
                If (LGreater (Local4, SOCP))
                {
                    Divide (Multiply (Subtract (Local4, SOCP), Local2), 3000000000, Local5, Local3)
                    Add (SOCP, Local3, SOCP)
                }
                Else
                {
                    Divide (Multiply (Subtract (SOCP, Local4), Local2), 3000000000, Local5, Local3)
                    Subtract (SOCP, Local3, SOCP)
                }
            }
        }
        If (LGreater (SOCP, 1000000))
        {
            Store (1000000, SOCP)
        }

        // cargador terminado / en pausa con cable y tension alta = lleno
        If (LAnd (LNotEqual (USBP, 0), LGreaterEqual (VBMV, 4300)))
        {
            If (LOr (LEqual (CHST, 5), LOr (LEqual (CHST, 6), LEqual (CHST, 7))))
            {
                Store (1000000, SOCP)
            }
        }
        Divide (SOCP, 1000, Local5, SOCF)
        Return (Zero)
    }

    // ------------------------------ ACPI ----------------------------------
    Name (BIFP, Package ()
    {
        0x00000000,         // unidad: mWh
        15400,              // capacidad de diseno
        15338,              // ultima carga completa
        0x00000001,         // recargable
        3850,               // tension de diseno, mV
        1534,               // aviso (10 %)
        767,                // bajo (5 %)
        1,                  // granularidad 1
        1,                  // granularidad 2
        "light_4000mah",    // modelo
        "0000",             // numero de serie
        "LION",             // tipo
        "Coslight"          // OEM
    })

    Method (_BIF, 0, NotSerialized)
    {
        Increment (NBIF)
        Return (BIFP)
    }

    Name (PBST, Package ()
    {
        0,
        0xFFFFFFFF,
        0xFFFFFFFF,
        0xFFFFFFFF
    })

    Method (_BST, 0, Serialized)
    {
        Increment (NBST)
        SMPL ()
        If (LEqual (SERR, 1))
        {
            Return (PBST)
        }

        // estado: bit0 descarga, bit1 carga, bit2 critico
        Store (Zero, Local0)
        If (LEqual (USBP, 0))
        {
            Store (1, Local0)
        }
        Else
        {
            If (LAnd (LGreaterEqual (CHST, 1), LLessEqual (CHST, 4)))
            {
                Store (2, Local0)
            }
        }
        If (LAnd (LEqual (USBP, 0), LLess (SOCF, 30)))
        {
            Or (Local0, 4, Local0)
        }

        // tasa en mW
        Divide (Multiply (IBMA, VBMV), 1000, Local5, Local1)
        // capacidad restante en mWh
        Divide (Multiply (SOCF, FULL), 1000, Local5, Local2)

        Store (Local0, Index (PBST, 0))
        Store (Local1, Index (PBST, 1))
        Store (Local2, Index (PBST, 2))
        Store (VBMV, Index (PBST, 3))
        Return (PBST)
    }

    // Solo el cable (para ADP1)
    Method (SPUS, 0, Serialized)
    {
        Acquire (SPMX, 0xFFFF)
        Store (Zero, SPER)
        Store (SPRD (2, 0x10, 1), Local0)
        Release (SPMX)
        If (SPER)
        {
            Return (USBP)
        }
        If (And (Local0, 0x10))
        {
            Store (1, USBP)
        }
        Else
        {
            Store (0, USBP)
        }
        Return (USBP)
    }
}

Device (ADP1)
{
    Name (_HID, "ACPI0003")
    Name (_UID, 0)
    Name (_PCL, Package () { \_SB })

    Method (_STA, 0, NotSerialized)
    {
        Return (0x0F)
    }

    Method (_PSR, 0, NotSerialized)
    {
        Increment (\_SB.BAT0.NPSR)
        Return (\_SB.BAT0.SPUS ())
    }
}
