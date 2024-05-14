#!/usr/bin/env python

# Utility to make some basic well-formedness checks on vhdl code generated
# using instgen utility with py-expander.

import sys
import re
from instgen import InstGen

re_endinst = re.compile( r'-- ENDINSTGEN' )
re_comment = re.compile( r'--.*' )
re_assign  = re.compile( r'^.*<=' )

def usage():
    print(sys.argv[0],'<insts json file> <generated vhdl file>')
    sys.exit(1)

def checkvhdl( genvhdlfile, assignableset ):
    endinstgen = False
    assignedvarset = set()
    for line in open( genvhdlfile ).readlines():
        if not endinstgen:
            if re_endinst.match( line ) != None:
                endinstgen = True
        else:
            linewocomment = re_comment.sub( "", line )
            if ( re_assign.match( linewocomment ) != None ):
                assignedvar = ( linewocomment.split()[0] )
                if assignedvar in assignedvarset:
                    print('duplicate assignment found:',assignedvar)
                else: assignedvarset.add( assignedvar )
    for var in [ var for var in assignedvarset if var not in assignableset ]:
        print('assigned but not declared',var)
    for var in [ var for var in assignableset if var not in assignedvarset ]:
        print('declared but not assigned',var)

if __name__ == '__main__':
    if len(sys.argv) != 3: usage()
    instgenspec = sys.argv[1]
    genvhdlfile = sys.argv[2]
    ig = InstGen( instgenspec )
    assignableset = set( ig.inpsignals() + ig.topopsignals() )
    checkvhdl( genvhdlfile, assignableset )
