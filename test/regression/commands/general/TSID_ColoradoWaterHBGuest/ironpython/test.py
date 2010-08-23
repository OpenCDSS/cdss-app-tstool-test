# Test web services

import wsdlprovider as wsdl

url = "http://www.dwr.state.co.us/HBGuest/HBGuestWebService.asmx?WSDL"
service = wsdl.GetWebservice(url)

def getAuthentication():
    header = service.HBAuthenticationHeader()
    header.Token = "WirQg1zN"
    return header

# Main code

status = service.HbStatusHeader()
districtArray = service.GetHBGuestWaterDistrictCompletedEventHandler(getAuthentication(), status)

