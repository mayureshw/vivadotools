#!/usr/bin/env bash

# Script to auto-convert entity declarations in vhdl files given as CLI arguments
# into a package containing the component declarations.

if [ $# -lt 2 ]
then
    echo "Usage: `basename $0` <pkgname> <vhdlfile...>"
    exit 1
fi

PKGNAME=$1
shift
SRCS=$*

(
sed -n '/^library/p' $SRCS | sort -u
echo
sed -n '/^use/p' $SRCS | grep -vw $PKGNAME | sort -u
echo
echo package $PKGNAME is
echo

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
' $SRCS

echo "end package;"

)
