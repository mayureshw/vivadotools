# Given a json file describing component instances, support class that helps in
# templatized generation of vhdl code
# include ( using $include(path) ) instgen.t, supplied in this directory, in
# your py-expander template to generate instancse as per the spec
# typically as: $include(environ['VIVADOTOOLSDIR'] + "/bin/instgen.t")

import json

class InstGen:

    def signalname(self,inst,port) : return inst+'_'+port

    def bindingstr(self,d): return ',\n'.join( ' '*8 + p + ' => ' + str(v) for p,v in d.items())

    def gettyp(self, instspec, portprops):
        typ = portprops[1]
        for param,val in instspec.get('generics',{}).items():
            typ = typ.replace( param, str(val) )
        return typ

    # iterator for tuples of signals and types, signal names in <inst>_<port> form
    def signals(self): return [ ( self.signalname(inst,port) ,self.gettyp( instspec, portprops ) )
        for inst,instspec in self.genspec['insts'].items()
        for port,portprops in self.pkgspec[instspec['component']].items()
        ]

    # iterator for tuples of instname, modulename, generic dictionary, list of port-signal pairs
    def insts(self): return [
        ( inst, instspec['component'], instspec.get('generics',{}), {
            port : self.signalname(inst,port) for port in self.pkgspec[instspec['component']]
            })
        for inst,instspec in self.genspec['insts'].items()
        ]

    # return iterator over instance names of a given component
    def instancesof(self, compname): return [ inst
        for inst,instspec in self.genspec['insts'].items() if instspec['component'] == compname
        ]

        
    def __init__( self, flnm ):
        self.genspec = json.load( open(flnm) )
        package = self.genspec['package']
        self.pkgspec = json.load( open(package+'.json') )
