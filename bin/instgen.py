#!/usr/bin/env python

# Given a json file describing component instances, generate the instantiation
# code using component description from a package file specified in the json
# generics are specified as a dictionary (optionally) signal declarations are
# generated automatically with <instname>_<compname> convention.

import json
import sys

def loadjson( flnm ):
    spec = json.load( open(flnm) )

def usage():
    print( sys.argv[0], "<instgen json file>" )
    sys.exit(1)

if __name__ == "__main__":
    if len( sys.argv ) != 2 : usage()
    loadjson( sys.argv[1] )
