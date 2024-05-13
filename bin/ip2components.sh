#!/usr/bin/env bash

# Script to extract ip component declarations into the package

IPSRCDIR=ipsrc

if [ $# -lt 1 ]
then
    echo "Usage: `basename $0` <ipname>" >&2
    exit 1
fi

IPNAME=`basename $1 .ip`

VHOFILE=$IPSRCDIR/$IPNAME/$IPNAME.vho
VEOFILE=$IPSRCDIR/$IPNAME/$IPNAME.veo

vho2comp()
{
    awk '
    /\<COMP_TAG_END\>/ { exit }
    PRT==1 { print }
    /\<COMP_TAG\>/ { PRT=1; next }
    ' $1
}

veo2comp()
{
    echo veo2comp not implemented: $1 >&2
}

if [ -f $VHOFILE ]
then
    vho2comp $VHOFILE
elif [ -f $VEOFILE ]
then
    veo2comp $VEOFILE
else
    echo "Neither vhdl nor verilog template found :" $VHOFILE $VEOFILE >&2
    echo "Run make $IPSRCDIR/$IPNAME/$IPNAME.xci beforehand to generate it" >&2
    exit 1
fi
