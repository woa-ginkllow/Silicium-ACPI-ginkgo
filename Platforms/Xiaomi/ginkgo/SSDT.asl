DefinitionBlock ("SSDT.aml", "SSDT", 2, "XIAOMI", "GINKGO  ", 3)
{
    External (\_SB.UFS0, DeviceObj)
    External (\_SB.SDC1, DeviceObj)

    Scope (\_SB)
    {
        Name (PSUB, "IDP06125")

        Scope (\_SB.UFS0)
        {
            Method (_STA, 0, NotSerialized) { Return (0x00) }
        }

        Scope (\_SB.SDC1)
        {
            Method (_STA, 0, NotSerialized) { Return (0x0F) }
        }

        Device (URS0)
        {
            Alias (\_SB.PSUB, _SUB)

            Name (_HID, "QCOM0497")
            Name (_CID, "PNP0CA1")
            Name (_UID, 0)
            Name (_CCA, 0)

            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite, 0x04E00000, 0x00100000)
            })

            Method (_STA, 0, NotSerialized) { Return (0x0F) }

            Device (USB0)
            {
                Name (_ADR, 0)
                Name (_S0W, 0)

                Name (_CRS, ResourceTemplate ()
                {
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )        { 0x11F }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, SharedAndWake, ,, ) { 0x14E }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, SharedAndWake, ,, ) { 0x1C6 }
                    Interrupt (ResourceConsumer, Edge,  ActiveHigh, SharedAndWake, ,, ) { 0x124 }
                })

                Name (_UPC, Package ()
                {
                    1,
                    9,
                    0,
                    0
                })

                Name (_PLD, Package ()
                {
                    Buffer ()
                    {
                        0x82,
                        0x00, 0x00, 0x00,
                        0x00, 0x00, 0x00, 0x00,
                        0x69,
                        0x0C,
                        0x00, 0x00,
                        0x00, 0x00, 0x00, 0x00,
                        0xFF, 0xFF, 0xFF, 0xFF
                    }
                })

                Method (CCVL, 0, NotSerialized) { Return (Buffer () { 2 }) }
                Method (HSEN, 0, NotSerialized) { Return (Buffer () { 0 }) }

                Method (_DSM, 4, Serialized)
                {
                    Switch (ToBuffer (Arg0))
                    {
                        Case (ToUUID ("CE2EE385-00E6-48CB-9F05-2EDB927C4899"))
                        {
                            Switch (ToInteger (Arg2))
                            {
                                Case (0)
                                {
                                    Switch (ToInteger (Arg1))
                                    {
                                        Case (0)
                                        {
                                            Return (Buffer () { 0x1D })
                                        }

                                        Default
                                        {
                                            Return (Buffer () { 1 })
                                        }
                                    }

                                    Return (Buffer () { 0 })
                                }

                                Case (2)
                                {
                                    Return (0)
                                }

                                Case (3)
                                {
                                    Return (0)
                                }

                                Case (4)
                                {
                                    Return (2)
                                }

                                Default
                                {
                                    Return (Buffer () { 0 })
                                }

                            }
                        }

                        Default
                        {
                            Return (Buffer () { 0 })
                        }
                    }
                }

                Method (PHYC, 0, Serialized)
                {
                    // TODO: Add Proper PHYC here.
                    Return ( Package () {} )
                }

                Method (_STA, 0, NotSerialized) { Return (0x0F) }
            }

            Device (UFN0)
            {
                Name (_ADR, 0)
                Name (_S0W, 0)

                Name (_CRS, ResourceTemplate ()
                {
                    Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )        { 0x11F }
                    Interrupt (ResourceConsumer, Level, ActiveHigh, SharedAndWake, ,, ) { 0x14E }
                })

                Name (_UPC, Package ()
                {
                    1,
                    9,
                    0,
                    0
                })

                Name (_PLD, Package ()
                {
                    Buffer ()
                    {
                        0x82,
                        0x00, 0x00, 0x00,
                        0x00, 0x00, 0x00, 0x00,
                        0x69,
                        0x0C,
                        0x00, 0x00,
                        0x00, 0x00, 0x00, 0x00,
                        0xFF, 0xFF, 0xFF, 0xFF
                    }
                })

                Method (CCVL, 0, NotSerialized) { Return (Buffer () { 2 }) }

                Method (_DSM, 4, Serialized)
                {
                    Switch (ToBuffer (Arg0))
                    {
                        Case (ToUUID ("FE56CFEB-49D5-4378-A8A2-2978DBE54AD2"))
                        {
                            Switch (ToInteger (Arg2))
                            {
                                Case (0)
                                {
                                    Switch (ToInteger (Arg1))
                                    {
                                        Case (0)
                                        {
                                            Return (Buffer () { 3 })
                                        }

                                        Default
                                        {
                                            Return (Buffer () { 1 })
                                        }
                                    }

                                    Return (Buffer () { 0 })
                                }

                                Case (1)
                                {
                                    Return ( 0x20 )
                                }

                                Default
                                {
                                    Return (Buffer () { 0 })
                                }
                            }
                        }

                        Case (ToUUID ("18DE299F-9476-4FC9-B43B-8AEB713ED751"))
                        {
                            Switch (ToInteger (Arg2))
                            {
                                Case (0)
                                {
                                    Switch (ToInteger (Arg1))
                                    {
                                        Case (0)
                                        {
                                            Return (Buffer () { 3 })
                                        }

                                        Default
                                        {
                                            Return (Buffer () { 1 })
                                        }
                                    }

                                    Return (Buffer () { 0 })
                                }

                                Case (1)
                                {
                                    Return ( 0x39 )
                                }

                                Default
                                {
                                    Return (Buffer () { 0 })
                                }
                            }
                        }

                        Default
                        {
                            Return (Buffer () { 0 })
                        }
                    }
                }

                Method (PHYC, 0, Serialized)
                {
                    // TODO: Add Proper PHYC here.
                    Return ( Package () {} )
                }

                Method (_STA, 0, NotSerialized) { Return (0x0F) }
            }
        }

		Device (TSC1)
		{
			Name (_HID, "NT03672A")
			Name (_UID, 0)
			Name (_CRS, ResourceTemplate ()
            {
				Memory32Fixed (ReadWrite, 0x4A88000,  0x4000)    // QUP SE2 (reg del nodo qupv3_se2_spi)
				Memory32Fixed (ReadWrite, 0x0400000,  0xc00000)   // tlmm
				Memory32Fixed (ReadWrite, 0x1400000,  0x1f0000)    // gcc
			})
		}
		
		Device (ADP1)
		{
			Name (_HID, "ACPI0003")
			Name (_PCL, Package () { \_SB })
			Method (_PSR, 0, NotSerialized) { Return (0) }   // 0 = sin cargador
		}
		
		Device (AMP1)
		{
			Name (_HID, "MAX98927")
			Name (_UID, 1)
			Method (_STA, 0, NotSerialized) { Return (0x0F) }
			Name (_CRS, ResourceTemplate ()
			{
				Memory32Fixed (ReadWrite, 0x04A84000, 0x00004000)   // GENI SE1
				Memory32Fixed (ReadWrite, 0x00400000, 0x00C00000)   // TLMM
				Memory32Fixed (ReadWrite, 0x01400000, 0x001F0000)   // GCC
			})
		}

		Device (BAT0)
		{
			Name (_HID, EisaId ("PNP0C0A"))
			Name (_UID, 1)
			Name (_PCL, Package () { \_SB })

			Method (_STA, 0, NotSerialized) { Return (0x1F) }

			Method (_BIF, 0, NotSerialized)
			{
				Return (Package () {
					1,        // unidad: mAh
					4000,     // capacidad de diseño
					4000,     // última carga completa
					1,        // recargable
					3870,     // voltaje de diseño (mV)
					600,      // aviso
					300,      // bajo
					10, 10,   // granularidades
					"BM46", "000001", "Li-poly", "Colight"
				})
			}

			Method (_BIX, 0, NotSerialized)
			{
				Return (Package () {
					0, 1, 4000, 4000, 1, 3870, 600, 300,
					0,        // ciclos
					95, 500, 100, 0, 0,
					10, 10,
					"BM46", "000001", "Li-poly", "Colight", 0
				})
			}

			Method (_BST, 0, NotSerialized)
			{
				Return (Package () {
					1,        // descargando
					500,      // mA
					3200,     // restante (80%)
					3900      // mV
				})
			}
		}
		
		Name (OCVT, Package ()      // { mV, % }, de mayor a menor
		{
			4383, 100,
			4264, 90,
			4150, 80,
			4048, 70,
			3960, 60,
			3869, 50,
			3828, 40,
			3803, 30,
			3768, 20,
			3706, 10,
			3653, 5,
			3547, 3,
			3337, 1,
			3000, 0
		})
		
		Method (V2P, 1, NotSerialized)     // Arg0 = mV, devuelve %
		{
			If (LGreaterEqual (Arg0, 4383)) { Return (100) }
			If (LLessEqual (Arg0, 3000)) { Return (0) }
			Store (0, Local0)
			While (LLess (Local0, 13))
			{
				// mV del par inferior
				Store (DerefOf (Index (OCVT, Add (Multiply (Local0, 2), 2))), Local1)
				If (LGreaterEqual (Arg0, Local1))
				{
					// mV superior, % superior, % inferior
					Store (DerefOf (Index (OCVT, Multiply (Local0, 2))), Local2)
					Store (DerefOf (Index (OCVT, Add (Multiply (Local0, 2), 1))), Local3)
					Store (DerefOf (Index (OCVT, Add (Multiply (Local0, 2), 3))), Local4)
					Divide (Multiply (Subtract (Arg0, Local1), Subtract (Local3, Local4)),
							Subtract (Local2, Local1), Local5, Local6)   // Local6 = cociente
					Return (Add (Local4, Local6))
				}
				Increment (Local0)
			}
			Return (0)
		}
    }
}
