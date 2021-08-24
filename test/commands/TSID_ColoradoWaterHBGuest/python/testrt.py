# Simple python script to test ColoradoWaterSMS web services, as per:
#
# https://fedorahosted.org/suds/wiki/Documentation

import logging

from suds.client import Client
from suds.sax.element import Element

# Setup logging

#logging.basicConfig(level=logging.DEBUG)
#logging.getLogger('suds.client').setLevel(logging.DEBUG)
#logging.getLogger('suds.transport').setLevel(logging.DEBUG)
#logging.getLogger('suds.xsd.schema').setLevel(logging.DEBUG)
#logging.getLogger('suds.wsdl').setLevel(logging.DEBUG)

authent = "WirQg1zN"
url = "http://www.dwr.state.co.us/SMS_WebService/ColoradoWaterSMS.asmx?WSDL"
client = Client(url)

# Indicate port to use
client.set_options(port='ColoradoWaterSMSSoap12')

# This will show service metadata like methods and object names
#print client

# Test using simple arguments
result = client.service.GetWaterDistricts()
print result

