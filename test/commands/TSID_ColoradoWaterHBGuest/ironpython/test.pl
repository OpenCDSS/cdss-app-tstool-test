use SOAP::Lite maptype => {};
# CONSTANTS
my $NS = 'http://www.dwr.state.co.us/';
my $SERV= 'http://www.dwr.state.co.us/HBGuest/HBGuestWebService.asmx';
runMethod('GetHBGuestSnowCourse','measNum=13692', 'startDate=1/1/1936', 'endDate=1/1/1937');
1;
sub runMethod {
my $method = shift;
# Generate the SOAP::Lite obj
my $soap = SOAP::Lite
-> uri($NS)
-> on_action( sub {sprintf '%s%s', @_ } )
-> proxy($SERV);
my %h = (Token=>'cyP1giEK');
my $header =
SOAP::Header->name(HBAuthenticationHeader=>\%h)->uri($NS)->prefix('');
my @params = ( $header );
my @pair;
# Attach parameters to the method call;
# 1st, make an array of SOAP::Data objects,
# which is a SOAP implementation of name - value pairs.
while (my $param = shift) {
@pair = split(/\=/, $param);
push(@params, SOAP::Data->name($pair[0]=>$pair[1]));
}
# Create a SOAP::Data objects for the name of the
# method to call. Note the Web Service namespace
# must be included.
my $methodSoap = SOAP::Data->name($method)->attr({xmlns=>$NS});
# The parameters are attached to the method call here.
# Use SOAP::SOM to parse results
my $som = $soap->call($methodSoap=>@params);
# Check for a fault: Call failure
if ($som->fault) {
my $logmsg =
"\nFault Detail: " . $som->faultdetail . "\n" .
"Fault Code: " . $som->faultcode . "\n" .
"Fault String: " . $som->faultstring . "\n";
print $logmsg;
return;
}
# Check the Header of Envelope, look for HbStatusHeader
# Check that for errors returned by the service.
my $status = $som->valueof('//HbStatusHeader/status');
if ($som->match('//HbStatusHeader/error/errorCode')) {
my $errCode = $som->valueof('//HbStatusHeader/error/errorCode');
my $errType = $som->valueof('//HbStatusHeader/error/errorType');
my $errMssg = $som->valueof('//HbStatusHeader/error/errorMessage');
my $errDesc = $som->valueof('//HbStatusHeader/error/exceptionDescription');
my $logmsg = "\nError code: $errCode\nError type: $errType" .
"\nError: $errMssg\nException: $errDesc\n";
print "$logmsg\n---------Failed!--------------\n\n";
return;
}
# Parse the response, print the results
if ($method eq 'GetHBGuestSnowCourse') {
my @results = $som->valueof("//$method" . "Result/SnowCourse");
my($res);
my($measNum,$measDate,$depth,$swe,$flag);
Page 45 of 46
print " Enumerating SnowCourseTS...\n";
foreach $res (@results) {
if ($res->{meas_date}){
$measDate = "(" . $res->{ meas_date} . ")";
} else { $measDate = ''; }
if ($res->{depth}) {
$depth = $res->{ depth};
} else { $depth = ''; }
if ($res->{ snow_water_equiv}) {
$swe= "(" . $res->{ snow_water_equiv} . ")";
} else { $swe = ''; }
if ($res->{ flag}) {
$flag = $res->{ flag};
} else { $flag = ''; }
print "\n Meas Number: " . $res->{meas_num} .
"\n Meas Date: " . $res->{meas_date} .
"\n Depth: " . $res->{depth} .
"\n SnowWater: " . $res->{ snow_water_equiv } .
"\n Flag: $flag\n";
}
print "\n --------------COMPLETE--------------\n\n";
return;
}
}
