// Reemplaza el dispositivo SPM1 anterior (dentro de Scope (\_SB)).
// Sin _CRS a proposito (el driver mapea con MmMapIoSpace).
//
// POLL: lo evalua spmiprobe cada 2 s. Lee el cable (BAT0.SPUS) y avisa a
//       Windows con Notify() cuando cambia, y cada ~14 s para refrescar el %.
// BATV: solo banco de pruebas (log). Puedes borrarlo cuando todo funcione.
Device (SPM1)
{
    Name (_HID, "GNKSPM01")
    Name (_UID, 0)

    Method (_STA, 0, NotSerialized)
    {
        Return (0x0F)
    }

    Name (LUSB, 0xFF)       // ultimo estado del cable visto (0xFF = ninguno)
    Name (PCNT, 0)          // vueltas desde el ultimo aviso periodico
    Name (NNTF, 0)          // avisos Notify enviados

    Method (POLL, 0, Serialized)
    {
        Store (\_SB.BAT0.SPUS (), Local0)
        Increment (PCNT)
        If (LNotEqual (Local0, LUSB))
        {
            Store (Local0, LUSB)
            Store (0, PCNT)
            Increment (NNTF)
            Notify (\_SB.ADP1, 0x80)        // cambio de _PSR
            Notify (\_SB.BAT0, 0x81)        // cambio de _BIF
            Notify (\_SB.BAT0, 0x80)        // cambio de _BST
        }
        Else
        {
            If (LGreaterEqual (PCNT, 7))
            {
                Store (0, PCNT)
                Increment (NNTF)
                Notify (\_SB.BAT0, 0x80)    // refresca % y estado
            }
        }
        Return (Local0)
    }

    Name (DBUF, Buffer (48) {})
    CreateDWordField (DBUF, 0, DUSB)
    CreateDWordField (DBUF, 4, DCHS)
    CreateDWordField (DBUF, 8, DVMV)
    CreateDWordField (DBUF, 12, DIMA)
    CreateDWordField (DBUF, 16, DING)
    CreateDWordField (DBUF, 20, DSOC)
    CreateDWordField (DBUF, 24, DERR)
    CreateDWordField (DBUF, 28, DRES)
    CreateDWordField (DBUF, 32, DEXT)   // _BST pedidos por Windows
    CreateDWordField (DBUF, 36, DIFN)   // _BIF
    CreateDWordField (DBUF, 40, DPSR)   // _PSR
    CreateDWordField (DBUF, 44, DNTF)   // Notify enviados

    Method (BATV, 0, Serialized)
    {
        Increment (\_SB.BAT0.NBVC)
        Store (\_SB.BAT0._BST (), Local0)
        Subtract (\_SB.BAT0.NBST, \_SB.BAT0.NBVC, DEXT)
        Store (\_SB.BAT0.NBIF, DIFN)
        Store (\_SB.BAT0.NPSR, DPSR)
        Store (NNTF, DNTF)
        Store (\_SB.BAT0.USBP, DUSB)
        Store (\_SB.BAT0.CHST, DCHS)
        Store (\_SB.BAT0.VBMV, DVMV)
        Store (\_SB.BAT0.IBMA, DIMA)
        Store (\_SB.BAT0.IBNG, DING)
        Store (\_SB.BAT0.SOCF, DSOC)
        Store (\_SB.BAT0.SERR, DERR)
        Store (DerefOf (Index (Local0, 2)), DRES)
        Return (DBUF)
    }
}
