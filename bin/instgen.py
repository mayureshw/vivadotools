# Given a json file describing component instances, support class that helps in
# templatized generation of vhdl code

import json

class InstGen:

    def gettyp(self, instspec, portprops):
        typ = portprops[1]
        for param,val in instspec.get('generics',{}).items():
            typ = typ.replace( param, str(val) )
        return typ

    # iterator for tuples of signals and types, signal names in <inst>_<port> form
    def signals(self): return [ ( '_'.join([inst,port]),self.gettyp( instspec, portprops ) )
        for inst,instspec in self.genspec['insts'].items()
        for port,portprops in self.pkgspec[instspec['component']].items()
        ]

        
    def __init__( self, flnm ):
        self.genspec = json.load( open(flnm) )
        package = self.genspec['package']
        self.pkgspec = json.load( open(package+'.json') )
        self.pkgspec.pop('dummy',None)
        for k,v in self.pkgspec.items(): v.pop('dummy',None)
