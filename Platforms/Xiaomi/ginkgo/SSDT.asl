// CreatorID=MSFT	CreatorRev=5.0.0
// FileLength=4415	FileChkSum=0x24

DefinitionBlock("SSDT.aml", "SSDT", 0x02, "XIAOMI", "GINKGO  ", 0x00000003)
{
    External (\_SB.UFS0, DeviceObj)
    External (\_SB.SDC1, DeviceObj)

    Scope(\_SB_)
    {
        Name(PSUB, "IDP06125")
        Scope(\_SB_.UFS0)
        {
            Method(_STA, 0x0, NotSerialized)
            {
                Return(Zero)
            }
        }

        Scope(\_SB_.SDC1)
        {
            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }
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

        Device(TSC1)
        {
            Name(_HID, "NT03672A")
            Name(_UID, Zero)

            Name(_CRS, ResourceTemplate()
            {
                Memory32Fixed(ReadWrite, 0x4a88000, 0x4000)
                Memory32Fixed(ReadWrite, 0x400000, 0xc00000)
                Memory32Fixed(ReadWrite, 0x1400000, 0x1f0000)
            })
        }

        Device(QWLN)
        {
            Name(_HID, "NICO1010")
            Name(_UID, Zero)

            Name(_CRS, ResourceTemplate()
            {
                Memory32Fixed(ReadWrite, 0xc800000, 0x800000)
                Memory32Fixed(ReadWrite, 0x57500000, 0x10000)
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x186}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x187}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x188}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x189}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x18a}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x18b}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x18c}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x18d}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x18e}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x18f}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x190}
                Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0x191}
            })
        }

        Device(ADSP)
        {
            Name(_HID, "NICO1005")
            Name(_UID, Zero)

            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }

            Name(_CRS, ResourceTemplate()
            {
                Memory32Fixed(ReadWrite, 0x46000000, 0x200000)
                Memory32Fixed(ReadWrite, 0x4b000000, 0x7e00000)
                Memory32Fixed(ReadWrite, 0x343000, 0x1000)
                Memory32Fixed(ReadWrite, 0xf111000, 0x1000)
                Memory32Fixed(ReadWrite, 0x55300000, 0x2200000)
            })
        }

        Device(AMP1)
        {
            Name(_HID, "MAX98927")
            Name(_UID, One)
            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }

            Name(_CRS, ResourceTemplate()
            {
                Memory32Fixed(ReadWrite, 0x4a84000, 0x4000)
            })
        }

        Device(AUD1)
        {
            Name(_HID, "GNKAUD01")
            Name(_UID, Zero)

            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }
        }

        Device(GPR0)
        {
            Name(_HID, "GNKGPU01")
            Name(_UID, Zero)
            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }
        }

        Device(GPU0)
        {
            Name(_HID, "GNKDSP01")
            Name(_UID, Zero)
            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }
            Method(_DOD, 0x0, NotSerialized)
            {
                Return(Package(One)
                {
                    0x80000400
                })
            }
            Device(LCD0)
            {
                Name(_ADR, 0x80000400)
                Method(_STA, 0x0, NotSerialized)
                {
                    Return(0xf)
                }
            }
        }

        Device(SPM1)
        {
            Name(_HID, "GNKSPM01")
            Name(_UID, Zero)

            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }

            Name(LUSB, 0xff)
            Name(PCNT, Zero)
            Name(NNTF, Zero)

            Method(POLL, 0x0, Serialized)
            {
                Store(\_SB_.BAT0.SPUS(), Local0)
                Increment(PCNT)
                If(LNot(LEqual(Local0, LUSB)))
                {
                    Store(Local0, LUSB)
                    Store(Zero, PCNT)
                    Increment(NNTF)
                    Notify(\_SB_.ADP1, 0x80)
                    Notify(\_SB_.BAT0, 0x81)
                    Notify(\_SB_.BAT0, 0x80)
                }
                Else
                {
                    If(LNot(LLess(PCNT, 0x7)))
                    {
                        Store(Zero, PCNT)
                        Increment(NNTF)
                        Notify(\_SB_.BAT0, 0x80)
                    }
                }
                Return(Local0)
            }

            Name(DBUF, Buffer(0x30)
            {
            })
            CreateDWordField(DBUF, Zero, DUSB)
            CreateDWordField(DBUF, 0x4, DCHS)
            CreateDWordField(DBUF, 0x8, DVMV)
            CreateDWordField(DBUF, 0xc, DIMA)
            CreateDWordField(DBUF, 0x10, DING)
            CreateDWordField(DBUF, 0x14, DSOC)
            CreateDWordField(DBUF, 0x18, DERR)
            CreateDWordField(DBUF, 0x1c, DRES)
            CreateDWordField(DBUF, 0x20, DEXT)
            CreateDWordField(DBUF, 0x24, DIFN)
            CreateDWordField(DBUF, 0x28, DPSR)
            CreateDWordField(DBUF, 0x2c, DNTF)

            Method(BATV, 0x0, Serialized)
            {
                Increment(\_SB_.BAT0.NBVC)
                Store(\_SB_.BAT0._BST(), Local0)
                Subtract(\_SB_.BAT0.NBST, \_SB_.BAT0.NBVC, DEXT)
                Store(\_SB_.BAT0.NBIF, DIFN)
                Store(\_SB_.BAT0.NPSR, DPSR)
                Store(NNTF, DNTF)
                Store(\_SB_.BAT0.USBP, DUSB)
                Store(\_SB_.BAT0.CHST, DCHS)
                Store(\_SB_.BAT0.VBMV, DVMV)
                Store(\_SB_.BAT0.IBMA, DIMA)
                Store(\_SB_.BAT0.IBNG, DING)
                Store(\_SB_.BAT0.SOCF, DSOC)
                Store(\_SB_.BAT0.SERR, DERR)
                Store(DerefOf(Index(Local0, 0x2, )), DRES)
                Return(DBUF)
            }
        }

        Device(BAT0)
        {
            Name(_HID, 0xa0cd041)
            Name(_UID, Zero)
            Name(_PCL, Package(0x1)
            {
                \_SB_
            })

            Method(_STA, 0x0, NotSerialized)
            {
                Return(0x1f)
            }

            OperationRegion(SPMW, SystemMemory, 0x3e00000, 0x10000)
            Field(SPMW, DWordAcc, NoLock, Preserve)
            {
                Offset(0x4580),
                CMDA, 32,
                , 32,
                STSA, 32,
                Offset(0x4598),
                RDAA, 32,
                Offset(0x4700),
                CMDC, 32,
                , 32,
                STSC, 32,
                Offset(0x4718),
                RDAC, 32,
                Offset(0x4e00),
                CMDD, 32,
                , 32,
                STSD, 32,
                Offset(0x4e18),
                RDAD, 32,
                Offset(0x5100),
                CMDE, 32,
                , 32,
                STSE, 32,
                Offset(0x5118),
                RDAE, 32
            }

            Mutex(SPMX, 0x0)
            Name(SPER, Zero)

            Method(SPRD, 0x3, NotSerialized)
            {
                Store(Or(0x8000000, Or(ShiftLeft(And(Arg1, 0xff, ), 0x4, ), Subtract(Arg2, One, ), ), ), Local0)
                Store(Zero, Local1)
                Store(Zero, Local2)
                Store(Zero, Local3)
                If(LEqual(Arg0, Zero))
                {
                    Store(Local0, CMDA)
                    While(LLess(Local2, 0x64))
                    {
                        Store(STSA, Local3)
                        If(And(Local3, One, ))
                        {
                            Break
                        }
                        Stall(0x2)
                        Increment(Local2)
                    }
                    If(LEqual(And(Local3, 0xf, ), One))
                    {
                        Store(RDAA, Local1)
                    }
                }
                Else
                {
                    If(LEqual(Arg0, 0x2))
                    {
                        Store(Local0, CMDC)
                        While(LLess(Local2, 0x64))
                        {
                            Store(STSC, Local3)
                            If(And(Local3, One, ))
                            {
                                Break
                            }
                            Stall(0x2)
                            Increment(Local2)
                        }
                        If(LEqual(And(Local3, 0xf, ), One))
                        {
                            Store(RDAC, Local1)
                        }
                    }
                    Else
                    {
                        Store(Local0, CMDD)
                        While(LLess(Local2, 0x64))
                        {
                            Store(STSD, Local3)
                            If(And(Local3, One, ))
                            {
                                Break
                            }
                            Stall(0x2)
                            Increment(Local2)
                        }
                        If(LEqual(And(Local3, 0xf, ), One))
                        {
                            Store(RDAD, Local1)
                        }
                    }
                }
                If(LNot(LEqual(And(Local3, 0xf, ), One)))
                {
                    Store(One, SPER)
                    Return(Zero)
                }
                If(LLess(Arg2, 0x4))
                {
                    Store(ShiftLeft(One, Multiply(Arg2, 0x8, ), ), Local4)
                    Decrement(Local4)
                    And(Local1, Local4, Local1)
                }
                Return(Local1)
            }
            Method(SPRS, 0x1, NotSerialized)
            {
                Store(Or(0x8000000, ShiftLeft(And(Arg0, 0xff, ), 0x4, ), ), Local0)
                Store(Zero, Local2)
                Store(Zero, Local3)
                Store(Local0, CMDE)
                While(LLess(Local2, 0x64))
                {
                    Store(STSE, Local3)
                    If(And(Local3, One, ))
                    {
                        Break
                    }
                    Stall(0x2)
                    Increment(Local2)
                }
                If(LNot(LEqual(And(Local3, 0xf, ), One)))
                {
                    Store(One, SPER)
                    Return(Zero)
                }
                Store(RDAE, Local1)
                Return(And(Local1, 0xff, ))
            }
            Name(USBP, Zero)
            Name(CHST, Zero)
            Name(VBMV, Zero)
            Name(IBMA, Zero)
            Name(IBNG, Zero)
            Name(SOCF, 0xffffffff)
            Name(ISPS, Zero)
            Name(ISNS, Zero)
            Name(SOCP, 0xffffffff)
            Name(LSTT, Zero)
            Name(SERR, One)
            Name(NBST, Zero)
            Name(NBVC, Zero)
            Name(NBIF, Zero)
            Name(NPSR, Zero)
            Name(RBMO, 0x50)
            Name(FULL, 0x3bea)
            Name(DESG, 0x3c28)
            Name(OCVT, Package(0x70)
            {
                0xbb8,
                Zero,
                0xd09,
                One,
                0xd8a,
                0x2,
                0xddb,
                0x3,
                0xe17,
                0x4,
                0xe45,
                0x5,
                0xe67,
                0x6,
                0xe73,
                0x7,
                0xe76,
                0x8,
                0xe78,
                0x9,
                0xe7a,
                0xa,
                0xe82,
                0xc,
                0xe90,
                0xe,
                0xea0,
                0x10,
                0xead,
                0x12,
                0xeb9,
                0x14,
                0xec4,
                0x16,
                0xecd,
                0x18,
                0xed3,
                0x1a,
                0xed8,
                0x1c,
                0xedb,
                0x1e,
                0xedf,
                0x20,
                0xee3,
                0x22,
                0xee8,
                0x24,
                0xeed,
                0x26,
                0xef4,
                0x28,
                0xefb,
                0x2a,
                0xf03,
                0x2c,
                0xf0b,
                0x2e,
                0xf14,
                0x30,
                0xf1e,
                0x32,
                0xf27,
                0x34,
                0xf31,
                0x36,
                0xf42,
                0x38,
                0xf5e,
                0x3a,
                0xf78,
                0x3c,
                0xf88,
                0x3e,
                0xf94,
                0x40,
                0xfa4,
                0x42,
                0xfba,
                0x44,
                0xfd0,
                0x46,
                0xfe5,
                0x48,
                0xff9,
                0x4a,
                0x100c,
                0x4c,
                0x1021,
                0x4e,
                0x1036,
                0x50,
                0x104c,
                0x52,
                0x1063,
                0x54,
                0x107a,
                0x56,
                0x1091,
                0x58,
                0x10a9,
                0x5a,
                0x10c1,
                0x5c,
                0x10d9,
                0x5e,
                0x10f1,
                0x60,
                0x1109,
                0x62,
                0x1120,
                0x64
            })
            Method(OCVS, 0x1, NotSerialized)
            {
                Store(SizeOf(OCVT), Local0)
                Store(DerefOf(Index(OCVT, Zero, )), Local2)
                If(LNot(LGreater(Arg0, Local2)))
                {
                    Return(Zero)
                }
                Store(DerefOf(Index(OCVT, Subtract(Local0, 0x2, ), )), Local2)
                If(LNot(LLess(Arg0, Local2)))
                {
                    Return(0x3e8)
                }
                Store(0x2, Local1)
                While(LLess(Local1, Local0))
                {
                    Store(DerefOf(Index(OCVT, Local1, )), Local2)
                    If(LNot(LGreater(Arg0, Local2)))
                    {
                        Store(DerefOf(Index(OCVT, Subtract(Local1, 0x2, ), )), Local3)
                        Store(DerefOf(Index(OCVT, Subtract(Local1, One, ), )), Local4)
                        Store(DerefOf(Index(OCVT, Add(Local1, One, ), )), Local5)
                        Subtract(Local2, Local3, Local6)
                        Multiply(Subtract(Arg0, Local3, ), Subtract(Local5, Local4, ), Local7)
                        Multiply(Local7, 0xa, Local7)
                        Divide(Local7, Local6, Local1, Local7)
                        Return(Add(Multiply(Local4, 0xa, ), Local7, ))
                    }
                    Add(Local1, 0x2, Local1)
                }
                Return(0x3e8)
            }
            Method(SMPL, 0x0, Serialized)
            {
                Acquire(SPMX, 0xffff)
                Store(Zero, SPER)
                Store(SPRD(0x2, 0x10, One), Local0)
                Store(SPRD(Zero, 0x6, One), Local1)
                Store(Zero, Local3)
                Store(Zero, Local4)
                Store(Zero, Local5)
                Store(Zero, ISPS)
                Store(Zero, ISNS)
                While(LLess(Local5, 0x4))
                {
                    Store(SPRD(0x3, 0xc0, 0x2), Local6)
                    If(LAnd(LGreater(Local6, Zero), LLess(Local6, 0x8000)))
                    {
                        Add(Local3, Local6, Local3)
                        Increment(Local4)
                    }
                    Store(SPRD(0x3, 0xc2, 0x2), Local7)
                    If(LNot(LEqual(Local7, 0x8000)))
                    {
                        If(And(Local7, 0x8000, ))
                        {
                            Add(ISNS, Subtract(0x10000, Local7, ), ISNS)
                        }
                        Else
                        {
                            Add(ISPS, Local7, ISPS)
                        }
                    }
                    Sleep(One)
                    Increment(Local5)
                }
                Release(SPMX)
                If(LOr(SPER, LEqual(Local4, Zero)))
                {
                    Store(One, SERR)
                    Return(Zero)
                }
                Store(Zero, SERR)
                If(And(Local0, 0x10, ))
                {
                    Store(One, USBP)
                }
                Else
                {
                    Store(Zero, USBP)
                }
                And(Local1, 0x7, CHST)
                Divide(Local3, Local4, Local5, Local3)
                Divide(Multiply(Local3, 0x4c08, ), 0x186a0, Local5, VBMV)
                If(LNot(LLess(ISPS, ISNS)))
                {
                    Store(Zero, IBNG)
                    Divide(Subtract(ISPS, ISNS, ), Local4, Local5, Local2)
                }
                Else
                {
                    Store(One, IBNG)
                    Divide(Subtract(ISNS, ISPS, ), Local4, Local5, Local2)
                }
                Divide(Multiply(Local2, 0x3b9b, ), 0x186a0, Local5, IBMA)
                Divide(Multiply(IBMA, RBMO, ), 0x3e8, Local5, Local6)
                If(IBNG)
                {
                    If(LGreater(VBMV, Local6))
                    {
                        Subtract(VBMV, Local6, Local7)
                    }
                    Else
                    {
                        Store(VBMV, Local7)
                    }
                }
                Else
                {
                    Add(VBMV, Local6, Local7)
                }
                Store(OCVS(Local7), Local6)
                If(LEqual(SOCP, 0xffffffff))
                {
                    Acquire(SPMX, 0xffff)
                    Store(Zero, SPER)
                    Store(SPRS(0x46), Local1)
                    Store(SPRS(0x47), Local2)
                    Release(SPMX)
                    If(LAnd(LEqual(SPER, Zero), LAnd(LEqual(Local1, One), LNot(LGreater(Local2, 0x64)))))
                    {
                        Multiply(Local2, 0x2710, SOCP)
                    }
                    Else
                    {
                        Multiply(Local6, 0x3e8, SOCP)
                    }
                    Store(Timer, LSTT)
                }
                Else
                {
                    Store(Timer, Local1)
                    Subtract(Local1, LSTT, Local2)
                    Store(Local1, LSTT)
                    If(LGreater(Local2, 0x23c34600))
                    {
                        Store(Zero, Local2)
                    }
                    Divide(Multiply(IBMA, Local2, ), 0x88c7a00, Local5, Local3)
                    If(IBNG)
                    {
                        Add(SOCP, Local3, SOCP)
                    }
                    Else
                    {
                        If(LGreater(SOCP, Local3))
                        {
                            Subtract(SOCP, Local3, SOCP)
                        }
                        Else
                        {
                            Store(Zero, SOCP)
                        }
                    }
                    If(LAnd(LLess(IBMA, 0x3c), LOr(LEqual(USBP, Zero), LNot(LLess(CHST, 0x5)))))
                    {
                        Multiply(Local6, 0x3e8, Local4)
                        If(LGreater(Local4, SOCP))
                        {
                            Divide(Multiply(Subtract(Local4, SOCP, ), Local2, ), 0xb2d05e00, Local5, Local3)
                            Add(SOCP, Local3, SOCP)
                        }
                        Else
                        {
                            Divide(Multiply(Subtract(SOCP, Local4, ), Local2, ), 0xb2d05e00, Local5, Local3)
                            Subtract(SOCP, Local3, SOCP)
                        }
                    }
                }
                If(LGreater(SOCP, 0xf4240))
                {
                    Store(0xf4240, SOCP)
                }
                If(LAnd(LNot(LEqual(USBP, Zero)), LNot(LLess(VBMV, 0x10cc))))
                {
                    If(LOr(LEqual(CHST, 0x5), LOr(LEqual(CHST, 0x6), LEqual(CHST, 0x7))))
                    {
                        Store(0xf4240, SOCP)
                    }
                }
                Divide(SOCP, 0x3e8, Local5, SOCF)
                Return(Zero)
            }
            Name(BIFP, Package(0xd)
            {
                Zero,
                0x3c28,
                0x3bea,
                One,
                0xf0a,
                0x5fe,
                0x2ff,
                One,
                One,
                "light_4000mah",
                "0000",
                "LION",
                "Coslight"
            })
            Method(_BIF, 0x0, NotSerialized)
            {
                Increment(NBIF)
                Return(BIFP)
            }
            Name(PBST, Package(0x4)
            {
                Zero,
                0xffffffff,
                0xffffffff,
                0xffffffff
            })
            Method(_BST, 0x0, Serialized)
            {
                Increment(NBST)
                SMPL()
                If(LEqual(SERR, One))
                {
                    Return(PBST)
                }
                Store(Zero, Local0)
                If(LEqual(USBP, Zero))
                {
                    Store(One, Local0)
                }
                Else
                {
                    If(LAnd(LNot(LLess(CHST, One)), LNot(LGreater(CHST, 0x4))))
                    {
                        Store(0x2, Local0)
                    }
                }
                If(LAnd(LEqual(USBP, Zero), LLess(SOCF, 0x1e)))
                {
                    Or(Local0, 0x4, Local0)
                }
                Divide(Multiply(IBMA, VBMV, ), 0x3e8, Local5, Local1)
                Divide(Multiply(SOCF, FULL, ), 0x3e8, Local5, Local2)
                Store(Local0, Index(PBST, Zero, ))
                Store(Local1, Index(PBST, One, ))
                Store(Local2, Index(PBST, 0x2, ))
                Store(VBMV, Index(PBST, 0x3, ))
                Return(PBST)
            }
            Method(SPUS, 0x0, Serialized)
            {
                Acquire(SPMX, 0xffff)
                Store(Zero, SPER)
                Store(SPRD(0x2, 0x10, One), Local0)
                Release(SPMX)
                If(SPER)
                {
                    Return(USBP)
                }
                If(And(Local0, 0x10, ))
                {
                    Store(One, USBP)
                }
                Else
                {
                    Store(Zero, USBP)
                }
                Return(USBP)
            }
        }

        Device(ADP1)
        {
            Name(_HID, "ACPI0003")
            Name(_UID, Zero)
            Name(_PCL, Package(0x1)
            {
                \_SB_
            })
            Method(_STA, 0x0, NotSerialized)
            {
                Return(0xf)
            }
            Method(_PSR, 0x0, NotSerialized)
            {
                Increment(\_SB_.BAT0.NPSR)
                Return(\_SB_.BAT0.SPUS())
            }
        }
    }
}
