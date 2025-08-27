#!/bin/csh -f

### Create abstraction defintion
baya-shell -ipxact2009 -f create_abstraction_definition.tcl 
grep 'Found [1-9]* error|Internal compiler error SIGNAL number|Out of Memory|Error: Could not find or load' baya-shell.log >& /dev/null

if ( 0 == $status ) exit 1

## Create bus defintion
baya-shell -ipxact2009 -f create_bus_definition.tcl 


