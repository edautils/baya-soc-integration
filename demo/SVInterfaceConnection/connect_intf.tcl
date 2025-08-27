
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

### Enable merging of the concat expressions in the port map
$verilogdescription setMergeConcat true

### Enable printing of the ranges in the port-map
$verilogdescription setPrintRangeInPortMap true

### Disable the interface portmaps while printing the portmaps
### of instances inside the top module
$verilogdescription setDisableInterfacePortMapMerging true

## Disable printing of components - if it is not disabled, it will
## print the components as blackbox/empty module
$verilogdescription setDisableBayaComponentPrinting true

### Lets set the file name to be associated with the top module
baya_set_file -name soc.v

### Read verilog files containing component definition
### Make sure that you the -sv switch
### The input file list contains the empty top module, just the module
### and its ports and no functionality
baya_import_verilog_filelist -filelist files.list -sv

### Set the current module as top ( this is the module without any body).
### We will be instantiating the components inside this module
baya_set_current_module -name top

### Let us instantiate the AXI interface in the current design and associate
### the top module's port with this. This instantiated AXI interface will be
### connected with the component's interface
set intf [ baya_create_sv_interface_instance -name axi_audio -master axi_bus ]

### Let us assocaite the top module's port with the interface ports
set pmap [ baya_create_port_map -formal axi_audio.clk -actual gclk ]
set pmap [ baya_create_port_map -formal axi_audio.reset_n -actual gresetn ]

### Create another instance of the AXI bus and associate to module's port
set intf [ baya_create_sv_interface_instance -name axi_gdma -master axi_bus ]
set pmap [ baya_create_port_map -formal axi_gdma.clk -actual gclk ]
set pmap [ baya_create_port_map -formal axi_gdma.reset_n -actual gresetn ]

### Create another instance of the AXI bus and associate to module's port
set intf [ baya_create_sv_interface_instance -name axi_demux -master axi_bus ]
set pmap [ baya_create_port_map -formal axi_demux.clk -actual gclk ]
set pmap [ baya_create_port_map -formal axi_demux.reset_n -actual gresetn ]

### Create another instance of the AXI bus and associate to module's port
set intf [ baya_create_sv_interface_instance -name axi_ddr -master axi_bus ]
set pmap [ baya_create_port_map -formal axi_ddr.clk -actual gclk ]
set pmap [ baya_create_port_map -formal axi_ddr.reset_n -actual gresetn ]

### Create another instance of the APB bus and associate to module's port
set intf [ baya_create_sv_interface_instance -name apb0 -master apb_bus ]
set pmap [ baya_create_port_map -formal apb0.clk -actual pclk ]
set pmap [ baya_create_port_map -formal apb0.reset_n -actual gresetn ]

### Create another instance of the APB bus and associate to module's port
set intf [ baya_create_sv_interface_instance -name apb1 -master apb_bus ]
set pmap [ baya_create_port_map -formal apb1.clk -actual pclk ]
set pmap [ baya_create_port_map -formal apb1.reset_n -actual gresetn ]


### Instantiate the components buswrp and dmxwrp
set inst [ baya_create_instance -name u_buswrp -master buswrp ]
set inst [ baya_create_instance -name u_dmxwrp -master dmxwrp ]

### Connect the top module's port with the u_buswrp instance's pin
baya_add_connection -src gclk -dest u_buswrp.gclk 
baya_add_connection -src gresetn -dest u_buswrp.gresetn 
baya_add_connection -src cpu_clk -dest u_buswrp.cpu_clk 
baya_add_connection -src cpu_resetn -dest u_buswrp.cpu_resetn 
baya_add_connection -src clk_phase -dest u_buswrp.clk_phase

### Now connect the AXI interface with the u_buswrp instance's interfaces
baya_create_interface_map -actual axi_audio -formal u_buswrp.axi_audio
baya_create_interface_map -actual axi_demux -formal u_buswrp.axi_demux
baya_create_interface_map -actual axi_dma -formal u_buswrp.axi_gdma
baya_create_interface_map -actual axi_ddr -formal u_buswrp.axi_ddr

### Now connect the interfaces of the u_buswrp component instance with
### the APB interfaces created in the top module
baya_create_interface_map -formal u_buswrp.apb_m -actual apb0 
baya_create_interface_map -formal u_buswrp.apb_s0 -actual apb0 
baya_create_interface_map -formal u_buswrp.apb_s1 -actual apb1 

### Create empty port connection(s)
baya_add_empty_connection -pin u_buswrp.sram_cen

### Associate constant values 
baya_add_constant_connection -dest u_buswrp.sram_dataout -value 64'h0

### Now define connection of the component instance u_dmxwrp
### It will have port-to-port  adhoc connection, constant values, interfaces
### 
baya_add_connection -src gclk -dest u_dmxwrp.gclk 
baya_add_connection -src gresetn -dest u_dmxwrp.gresetn 
baya_add_connection -src dmx_resetn -dest u_dmxwrp.rst_n 
baya_add_connection -src clk_phase -dest u_dmxwrp.dmx_clk
baya_add_connection -src clk_phase -dest u_dmxwrp.clk_phase

baya_create_interface_map -formal u_dmxwrp.apb_dmx -actual apb1 
baya_create_interface_map -formal u_dmxwrp.axi_dmx -actual axi_demux 

baya_add_constant_connection -dest u_dmxwrp.ts_clk_a -value 1'b0
baya_add_constant_connection -dest u_dmxwrp.fr_ts_sync_a -value 1'b0
baya_add_constant_connection -dest u_dmxwrp.fr_ts_dvalid_a -value 1'b0
baya_add_constant_connection -dest u_dmxwrp.fr_ts_di_a -value 8'h0
baya_add_constant_connection -dest u_dmxwrp.fr_ts_derr_a -value 1'b0

baya_add_empty_connection -pin u_dmxwrp.out_int

#### End of the port connection

### Print the top module into the file soc.v as set with the baya_set_file 

baya_print_verilog_file

exit

