# Simple python script to test ColoradoWaterHBGuest web services, as per:
#
# https://fedorahosted.org/suds/wiki/Documentation

import logging

from suds.client import Client
from suds.sax.element import Element

# Setup logging

logging.basicConfig(level=logging.DEBUG)
logging.getLogger('suds.client').setLevel(logging.DEBUG)
#logging.getLogger('suds.transport').setLevel(logging.DEBUG)
#logging.getLogger('suds.xsd.schema').setLevel(logging.DEBUG)
#logging.getLogger('suds.wsdl').setLevel(logging.DEBUG)

authent = "WirQg1zN"
url = "http://www.dwr.state.co.us/HBGuest/HBGuestWebService.asmx?WSDL"
client = Client(url)

# Indicate which port (set of methods should be used)
client.set_options(port='ColoradoWaterHBGuestSoap12')

# This will show service metadata like methods and object names
#print client

# Set up the authentication header (header name and namespace)
tokenns = ( "HBAuthenticationHeader", "http://www.dwr.state.co.us/" )
# Create the header as list of elements (property name and value)
hbauth = Element ('HBAuthenticationHeader', ns=(None,"http://www.dwr.state.co.us/") )
authentHeaderToken = Element ('Token').setText(authent)
authentHeaderUserID = Element ('UserID').setText("0")
hbauth.append(authentHeaderToken)
hbauth.append(authentHeaderUserID)
client.set_options(soapheaders=hbauth)

# Test method calls
# TODO SAM 2010-08-16 Need to figure out how to get return status

# Water districts
#result = client.service.GetHBGuestWaterDistrict()
#print result

# Meastypes for structure
#result = client.service.GetHBGuestStructureGeolocMeasTypeByWD(47,"DivTotal")
#print result

# Annual diversion for structure
#result = client.service.GetHBGuestStructureAnnuallyTSByWDID("4700500",1949,2009)
#print result

# Monthly diversion for structure
result = client.service.GetHBGuestStructureMonthlyTSByWDID("2000812",1949,2009)
print result

