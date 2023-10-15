#!/usr/bin/env python

# support script for xcicat.sh

import sys
import json

jsonfile = sys.argv[1]
jsonobj = json.load( open(jsonfile) )
pvs = jsonobj['ip_inst']['parameters']['component_parameters']
for p,v in pvs.items():
    print(p,v[0]['value'])
