
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

### enable the merging of the concat expressions in the portmaps 
### 
$verilogdescription setMergeConcat true

### Set the top file where the top module to be written 
baya_set_file -name soc.v

## Read the Verilog files containing the modules to be instantiated in the
## top module
baya_import_verilog -file src/A.v 
baya_import_verilog -file src/B.v
baya_import_verilog -file src/C.v
baya_import_verilog -file src/D.v


## Create the top module i.e. the SoC or the SubSystem 
baya_create_module  -name MySoC

## Set the above create module as the current design
baya_set_current_module -name MySoC

## Instantiate modules through one single command
baya_create_instances -insts u_A(A),u_B(B),u_C(C),u_D(D)

## Now, auto connect the instances similar to that of the SystemVerilog 
## Exclude the selective pins from being autoconnected
baya_auto_connect -insts u_A,u_B,u_C,u_D -exclude b(u_D:u_C),c(u_B:u_C),c(u_D:u_B),b(u_A:u_C)

## Now, intruct the tool to create ports in the top module corresponding
## to the instance pins which are not connected 
baya_create_auto_ports

## Elaborate the design
baya_elaborate
 
### Pring the verilog int the STDOUT
baya_print_verilog

## Print the current design in the file soc.v set with the command baya_set_file
baya_print_verilog_file

exit

