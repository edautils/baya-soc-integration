
$verilogdescription setMergeConcat true

baya_set_file -name soc.v
baya_set_line -num 0

set socname top
baya_create_module -name $socname


# top level ports
baya_create_port -name CLK -dir in 
baya_create_port -name RESET -dir in 
baya_create_port -name STRTSTOP -dir in 
baya_create_port -name ONES -dir in -range "7:0"
baya_create_port -name TENS -dir in -range "7:0"
baya_create_port -name TENTHS -dir in -range "7:0"

# design files
baya_import_verilog -file modules/DEBOUNCE.v
baya_import_verilog -file modules/CLK_DIV.v
baya_import_verilog -file modules/WATCH_MACHINE.v
baya_import_verilog -file modules/UP_COUNTER.v
baya_import_verilog -file modules/HEX2LED.v 

# top level module
baya_set_current_module -name $socname
baya_import_connectivity_from_modular_csv_dir -dirs csv-modular
baya_set_current_module -name $socname
# elaborate top level module

baya_elaborate -module $socname
baya_print_verilog_file 
exit
