#!/usr/bin/env bash

# Utility to create json representation of a package file in vhdl for use with
# instgen.py utility.
#
# Does very rudimentary parsing and should be treated as experimental

PKG=$1

if [ ! -f "$PKG" ]
then
    echo "No such package file $PKG"
    exit 1
fi

JSONFILE=`basename $PKG .vhdl`.json

awk '
BEGIN { print "{" }
END {
    print "\"dummy\" : {}"
    print "}"
    }
/^component/ || /^COMPONENT/ {
    COMP = $2
    COMPDONE = 0
    print "\"" COMP "\"", ": {"
    next
    }
/^ *port *\(/ || /^ *PORT *\(/ { PORTON = 1; next }
PORTON==1 && ( /^ *)/ || /^end component/ ) {
    PORTON = 0
    print "    \"dummy\" : []"
    print "    },"
    COMPDONE = 1
    next
    }
COMPDONE == 0 && /end component/ {
    print "    },"
    COMPDONE = 1
    next
    }
/^ *--/ { next; }
/^ *$/ { next; }
PORTON != 1 { next }
    {
        PORTNAME = $1
        PORTDIR = $3
        gsub("--.*","")
        gsub(";.*","")
        gsub("))$",")") # hack for declarations that end hte port also
        PORTTYP=""
        for(i=4;i<=NF;i++) PORTTYP=PORTTYP " " $i
        print "    \"" PORTNAME "\": [ \"" PORTDIR "\", \"" PORTTYP "\" ],"
    }
    ' $PKG > $JSONFILE
