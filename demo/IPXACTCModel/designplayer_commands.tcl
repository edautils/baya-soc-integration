### Sample Tcl commands to show the power DesignPlayer platform where Verilog
### and the IP-XACT have been integrated. The designer can generate the 
### Regsiter C model, Verilog design and many more ...

$logmessages addSuppressedMessageID 50199
$baya setFile "design_apbSubSystem.v"

set designFile ../CommonData/IPXACTCompLib/spiritconsortium.org/Leon2RTL/System5/apbSubSystem/design_apbSubSystem.xml
set compFile ../CommonData/IPXACTCompLib/spiritconsortium.org/Leon2RTL/System5/apbSubSystem/apbSubSystem.xml

### Set the IP-XACT search paths to load the component and bus and abstraction
### definition

baya_set_ipxact_search_path -paths ../CommonData/IPXACTCompLib:../CommonData/BusDefs/global

### Load the IP-XACT Design file along with associated components
### Please note that this IP-XACT Design can be created with IP-XACT
### Tcl commands or by using ipxact2verilog tool ( use the -design switch )
###
baya_import_ipxact -design $designFile -component $compFile

### Elaborate imported IP-XACT design which will link the referred
### component instances 
baya_elaborate -module apbSubSystem
 
### Generate REGISTER C model corresponding to the enite design
baya_generate_ipxact_design_c_model -design apbSubSystem
## You can add connections in the loaded IP-XACT design mature it
## See, Tcl command reference to get the list available command
##
### Prind the Design XML as Verilog design for rest of the implementation
### steps e.g. DV/Synthesis ... You can 
baya_print_verilog_file -file apbSS.v

exit

