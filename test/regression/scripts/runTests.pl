#### setup the classpath ####
$TSTool = "../dist/TSTool_142.jar";
$NWSRFS_DMI = "externals/NWSRFS_DMI/NWSRFS_DMI_142.jar";
$StateCU = "externals/StateCU/StateCU_142.jar";
$StateMod = "externals/StateMod/StateMod_142.jar";
$RTi = "externals/RTi_Common/RTi_Common_142.jar";
$TS_Services = "externals/TS_Services/TS_Services.jar";
$Riverside = "externals/RiversideDB_DMI/Riverside_DMI_142.jar";
$Blowfish = "externals/Blowfish_142.jar";
$Satmon = "externals/SatmonSysDMI/SatmonSysDMI_142.jar";
$Hydro = "externals/HydroBaseDMI/HydroBaseDMI_142.jar";
$msbase = "externals/Microsoft_SQL_Server_Java_ODBC_Driver/msbase.jar";
$mssql = "externals/Microsoft_SQL_Server_Java_ODBC_Driver/mssqlserver.jar";
$msutil = "externals/Microsoft_SQL_Server_Java_ODBC_Driver/msutil.jar";
$abbot = "externals/Abbot/abbot.jar";
$jdom = "externals/Abbot/jdom.jar";
$xerces = "externals/Abbot/xerces.jar";
$xml_apis = "externals/Abbot/xml-apis.jar";
$jgraph = "externals/Abbot/jgraph.jar";
$bsh	= "externals/Abbot/bsh.jar";
$MRJ = "externals/Abbot/MRJToolkitStubs.zip";
$gnu_regexp = "externals/Abbot/gnu-regexp.jar";
$ant4eclipse = "externals/Abbot/ant4eclipse.jar";
$junit = "externals/Abbot/junit.jar";
$classpath = "";
$classname = "junit.extensions.abbot.ScriptFixture";
$script_dir = "test/regression/scripts";
@scripts = `ls *.xml`;

my $os = $^O;
if($os =~ /win/i)
{
  $classpath = "$TSTool;$msbase;$mssql;$msutil;$NWSRFS_DMI;$StateCU;$StateMod;$TS_Services;$Riverside;$Blowfish;$Satmon;$Hydro;$RTi;$abbot;$jdom;$xerces;$xml_apis;$jgraph;$bsh;$MRJ;$gnu_regexp;$ant4eclipse;$junit;.";
}
else
{
  $classpath = "$TSTool:$msbase:$mssql:$msutil:$NWSRFS_DMI:$StateCU:$StateMod:$TS_Services:$Riverside:$Blowfish:$Satmon:$Hydro:$RTi:$abbot:$jdom:$xerces:$xml_apis:$jgraph:$bsh:$MRJ:$gnu_regexp:$ant4eclipse:$junit:.";
}

#### change to the TSTool main directory to run ####
chdir ("../../../");

foreach $file (@scripts)
{
   if($file !~ /fixture/i)
   {
     chomp ($file);
     $path_to_file = "$script_dir" . "/" . "$file";
     print "RUNNING SCRIPT:$path_to_file\n";
     print "RUNNING: java -cp \"$classpath\" $classname $path_to_file\n";
     
     #### run the abbot scriptFixture class to run scripts
     `java -cp \"$classpath\" $classname $path_to_file`;
     
     ### sleep for 10 seconds to allow abbot to cleanup ####
     sleep 10;
   }
}