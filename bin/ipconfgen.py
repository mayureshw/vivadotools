#!/usr/bin/env python
# A command line tool to convert configuration json file of an object to
# arguments to the ipgen tool
# json file format:
# Filename: <module.ip>
# {
#   "vlnv" : <vlnvstring of the ip>,
#   "props" : {
#        < dictionary of configurable properties and their values >
#        }
# }
import json
import sys
from pathlib import Path

def ipfile2argstr(ipfile):
    modulename = ipfile.stem
    conf = json.load(ipfile.open())
    props = ['vlnv','props']
    for prop in props:
        if prop not in conf:
            print('Property', '"'+prop+'"' ,'not found in file',ipfile)
            sys.exit(1)
    vlnv = conf['vlnv']
    props = conf['props']
    if not isinstance(props,dict):
        print('"props" needs to be a dictionary')
        sys.exit(1)
    return vlnv + ' all ' + ' '.join( p + ' ' + v for p,v in props.items() )
    

def usage(): print(sys.argv[0],"<ipfilename>")

if __name__ == '__main__':
    if len( sys.argv ) != 2:
        usage()
        sys.exit(1)

    ipfile = Path( sys.argv[1] )
    if not ipfile.is_file():
        print('File not found',ipfile)
        sys.exit(1)
    
    argstr = ipfile2argstr(ipfile)
    print(argstr)
