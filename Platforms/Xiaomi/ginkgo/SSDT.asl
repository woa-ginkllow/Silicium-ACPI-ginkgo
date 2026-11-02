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
		
        Device (QWLN)
        {
            Name (_HID, "NICO1010")
            Name (_UID, 0)

            Name (_CRS, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite, 0x0C800000, 0x00800000)
                Memory32Fixed (ReadWrite, 0x57500000, 0x00010000)

				// Interrupts
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x186 }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x187 }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x188 }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x189 }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x18A }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x18B }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x18C }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x18D }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x18E }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x18F }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x190 }
                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) { 0x191 }
            })
        }

		Device (ADSP)
		{
			Name (_HID, "NICO1005")
			Name (_UID, 0)

			Method (_STA, 0, NotSerialized)
			{
				Return (0x0F)
			}

			Name (_CRS, ResourceTemplate ()
			{
				Memory32Fixed (ReadWrite, 0x46000000, 0x00200000)
				Memory32Fixed (ReadWrite, 0x4B000000, 0x07E00000)
				Memory32Fixed (ReadWrite, 0x00343000, 0x00001000)
				Memory32Fixed (ReadWrite, 0x0F111000, 0x00001000)
				Memory32Fixed (ReadWrite, 0x55300000, 0x02200000)
			})
		}

		Device (AMP1)
		{
			Name (_HID, "MAX98927")
			Name (_UID, 1)
			Method (_STA, 0, NotSerialized) { Return (0x0F) }
			Name (_CRS, ResourceTemplate ()
			{
				Memory32Fixed (ReadWrite, 0x04A84000, 0x00004000)   // GENI SE1
			})
		}

		Device (AUD1)
		{
			Name (_HID, "GNKAUD01")
			Name (_UID, 0)

			Method (_STA, 0, NotSerialized)
			{
				Return (0x0F)
			}
		}
		Include ("spmiprobe_acpi.asl")
		Include ("ginkgo_battery.asl")
    }
}
