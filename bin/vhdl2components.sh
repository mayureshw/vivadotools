#!/usr/bin/env bash

# Script to auto-convert entity declarations in vhdl and ip files given as CLI
# arguments into a package containing the component declarations.  (make must
# be run with ipsrc/$ip/$ip.xci as a target beforehand so that this utility
# finds the component declarations.)

if [ $# -lt 2 ]
then
    echo "Usage: `basename $0` <pkgname> <vhdlfile...> [ipfile...]" >&2
    exit 1
fi

PKGNAME=$1
shift
SRCS=$*
VHDLSRCS=""
IPSRCS=""
for SRC in $SRCS
do
    if [ ! -f "$SRC" ]
    then
        echo "File not found: " $SRC >&2
        exit 1
    fi
    if [[ "$SRC" =~ .vhdl$ ]]
    then
        VHDLSRCS="$VHDLSRCS $SRC"
    elif [[ "$SRC" =~ .ip$ ]]
    then
        IPSRCS="$IPSRCS $SRC"
    else
        echo "`basename $0` Only .vhdl and .ip extension supported: " $SRC >&2
        exit 1
    fi
done

(
sed -n '/^library/p' $VHDLSRCS | sort -u
echo
sed -n '/^use/p' $VHDLSRCS | grep -vw $PKGNAME | sort -u
echo
echo package $PKGNAME is
echo

TYPESFILE=${PKGNAME}_types.vhdl
if [ -f $TYPESFILE ]
then
    cat $TYPESFILE
    echo
fi

awk '
/\<attribute\>/ { next }
/^entity/ {
    GO = 1
    gsub("entity","component")
    print
    next
    }
/^end entity/ {
    GO = 0
    gsub("entity","component")
    print $0 "\n"
    }
GO { print }
' $VHDLSRCS

for IPSRC in $IPSRCS
do
    ip2components.sh $IPSRC
    if [ $? -ne 0 ]
    then
        exit 1
    fi
done

echo "end package;"

PBODYFILE=${PKGNAME}_pbody.vhdl
if [ -f $PBODYFILE ]
then
    echo
    cat $PBODYFILE
fi

)
