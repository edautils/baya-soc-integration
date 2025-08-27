
################################################################################
##          Copyright (c) 2012 -2012 edautils.com
##
##    This source code is free software; you can redistribute it
##    and/or modify it in source code form under the terms of the GNU
##    General Public License as published by the Free Software
##    Foundation; either version 2 of the License, or (at your option)
##    any later version.
##
##    This program is distributed in the hope that it will be useful,
##    but WITHOUT ANY WARRANTY; without even the implied warranty of
##    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##    GNU General Public License for more details.
##
##    You should have received a copy of the GNU General Public License
##    along with this program; if not, write to the Free Software
##    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
##
##    Contact help@edautils.com you need more information/support
################################################################################

$baya setFile "design_apbSubSystem.v"

### Set the IP-XACT Search paths - all the IP-XACT files in this search 
### paths will be loaded
### Note that thet search paths are separated with colon ':'
###


baya_set_ipxact_search_path -paths ../CommonData/IPXACTCompLib:../CommonData/BusDefs/global

### Instantiate IP-XACT components by specifying the VLNV
### It is expected that there existted a component with same
### VLNV in the specified search path

baya_import_ipxact -component modules/System1/apbSubSystem/apbSubSystem.xml
baya_set_current_design -name apbSubSystem

baya_create_instance -name i_apbbus9 -vlnv spiritconsortium.org/Leon2RTL/apbbus9/1.3
baya_create_instance -name i_apbmst -vlnv spiritconsortium.org/Leon2RTL/apbmst/1.2
baya_create_instance -name i_irqctrl -vlnv spiritconsortium.org/Leon2RTL/irqctrl/1.2
baya_create_instance -name i_timers -vlnv spiritconsortium.org/Leon2RTL/timers/1.2
baya_create_instance -name i_uart -vlnv spiritconsortium.org/Leon2RTL/uart/1.2
baya_create_instance -name i_uart_1 -vlnv spiritconsortium.org/Leon2RTL/uart/1.2
baya_create_instance -name i_uartcrosser -vlnv spiritconsortium.org/Leon2RTL/uartcrosser/1.2

### Connect the interfaces 
###
baya_connect_interfaces -from i_apbmst.ambaAPB -to i_apbbus9.MirroredMaster

baya_connect_interfaces -from i_irqctrl.ambaAPB -to i_apbbus9.MirroredSlave0
baya_connect_interfaces -from i_timers.ambaAPB -to i_apbbus9.MirroredSlave1
 
baya_connect_interfaces -from i_uart.ambaAPB -to i_apbbus9.MirroredSlave2
baya_connect_interfaces -from i_uart_1.ambaAPB -to i_apbbus9.MirroredSlave3

## Hier connections - interface of the top design
baya_connect_interfaces -from i_apbbus_slv4 -to i_apbbus9.MirroredSlave4
baya_connect_interfaces -from Interrupt -to i_irqctrl.MasterInt

### Create adhoc connections

baya_add_constant_connection -dest i_irqctrl.irq(14) -value 0
baya_add_constant_connection -dest i_irqctrl.irq(13) -value 0
baya_add_constant_connection -dest i_irqctrl.irq(7) -value 0
baya_add_constant_connection -dest i_timers.ntrace -value 0
baya_add_constant_connection -dest i_timers.lresp -value 0
baya_add_constant_connection -dest i_timers.dresp -value 0
### 
### Save the current module as Verilog
baya_print_verilog_file -file apbSubSystem.v
## save the current design as IP-XACT Design
#baya_save_as_ipxact_design -xml apbss.design.xml
## Save the connection database for future reference 
baya_save_connection_db -xml BayaConnectionDB.xml

exit

