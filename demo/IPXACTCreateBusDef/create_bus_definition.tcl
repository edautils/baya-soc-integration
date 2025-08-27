###
### Tcl commands to create the IP-XACT bus definition file
###

### Create the abstraction definition object
###

set bd [ ipxact_create_bus_def -vendor spiritconsortium.org -lib busdef.clock -name clock -version 1.0 ]

## Set attributes of this buse defintion
$bd setDirectConnection true
$bd setIsAddressable false

## Set description for this bus definition
ipxact_set_description $bd "This is Clock Bus Definition is created with the EDAUtils IP-XACT Tcl commands"

## Save this bus definition
$ipxactroot saveBusDefinitionIntoFile $bd clock.bd.xml


