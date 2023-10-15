#!/usr/bin/env python

# support script for xcicat.sh

import sys
import xml.etree.ElementTree as ET
import re

tagprefixre = re.compile(r'^\{.*\}')
paramvaluere = re.compile(r'^PARAM_VALUE\.')

def simplifyTag(tag): return re.sub(tagprefixre,'',tag)
def simplifyParam(p): return re.sub(paramvaluere,'',p)

def element2dict(node):
    return { simplifyTag(child.tag):child for child in node }

xmlfile = sys.argv[1]
tree = ET.parse(xmlfile)
root = tree.getroot()

l1 = element2dict(root)

for prop in ['vendor','library','name','version']:
    print(prop,l1[prop].text)

compinst = element2dict( l1['componentInstances'][0] )
propvals = compinst['configurableElementValues']
for pv in propvals:
    p = next(iter(pv.attrib.values()))
    if re.match(paramvaluere,p):
        print(simplifyParam(p),pv.text)
