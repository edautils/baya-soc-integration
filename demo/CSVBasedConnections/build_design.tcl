
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

### Set various setup related flags 
$verilogdescription setMergeConcat true
$verilogdescription setPrintRangeInPortMap true


### Import the verilog files containing the component definitions and
### also import the empty top module- MySoC, defined in the top.v ...
baya_import_verilog_filelist -filelist infile.list -sv

### Import the connectivity file
baya_import_connectivity_csv -file BayaConnections.csv

baya_set_current_design -name MySoC
### Elaborate the 
baya_elaborate -module MySoC

baya_get_maturity_status

baya_print_verilog_file -file soc.v

exit

