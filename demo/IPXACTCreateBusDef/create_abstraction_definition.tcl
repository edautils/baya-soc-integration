###
### Tcl commands to create the IP-XACT abstraction definition file
###

### Create the abstraction definition object
###
set ad [ ipxact_create_abstraction_def -vendor http://www.edautils.com -lib mylib -name clock_rtl -version 1.0 ]

### Create the library ref object to set bustype
set bustype [ $ipxactroot createAbstractionDefLibraryRefType edautils.com/busdef.clock/clock/1.0 ]
$ad setBusType $bustype

## Create portList
set ports [ java::new com.eu.miscedautils.ipxact2009.AbstractionDefinition.AbstractionDefinition.Ports ]
$ad setPorts $ports
set portList [$ports getPort]

### Create a port and add the same in the portlist
set port [ java::new com.eu.miscedautils.ipxact2009.AbstractionDefinition.AbstractionDefinition.Ports.Port ]
$port setLogicalName CLK
$portList add $port

set wire [java::new com.eu.miscedautils.ipxact2009.AbstractionDefinition.AbstractionDefinition.Ports.Port.Wire]
$port setWire $wire

set qualifier [ java::new com.eu.miscedautils.ipxact2009.AbstractionDefinition.AbstractionDefinition.Ports.Port.Wire.Qualifier ]
$wire setQualifier $qualifier
$qualifier setIsClock true


set onm [java::new com.eu.miscedautils.ipxact2009.AbstractionDefinition.AbstractionDefinition.Ports.Port.Wire.OnMaster]
$wire setOnMaster $onm
set width [$ipxactroot createBigIntegerValue 1]
$onm setWidth $width
$onm setDirection out

set ons [java::new com.eu.miscedautils.ipxact2009.AbstractionDefinition.AbstractionDefinition.Ports.Port.Wire.OnSlave]
$wire setOnSlave $ons
set width [$ipxactroot createBigIntegerValue 20]
$ons setWidth $width
$ons setDirection in

### End of port creation - repeat the same if you want to add another port
###

### Set a description for this abstraction definition
ipxact_set_description $ad "This is Clock Abstraction Definition is created with the EDAUtils IP-XACT Tcl commands"

## Save this abstraction definition
$ipxactroot saveAbstractionDefinitionIntoFile $ad clock.ad.xml

