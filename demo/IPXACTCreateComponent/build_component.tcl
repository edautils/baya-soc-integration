$verilogdescription setV95 true
set comp [ ipxact_read_verilog_filelist -filelist "rtl/files.list" -top i2c -incdir +incdir+rtl -v95 ]

set clk_ad [ ipxact_load_abstraction_def_file -xml busdefs/clock_rtl.ad.xml ]
set clk_bd [ ipxact_load_bus_def_file -xml busdefs/clock.bd.xml ]

set clk_bif [ ipxact_create_slave_bus_interface  -name clk_intf  -mem_map_ref mem_ref1 -bridge_master_interface bridge_intf1 -ad $clk_ad -bd $clk_bd -opaque -conn_required ]
set comp [ipxact_component_add_bus_interface -component $comp -bif $clk_bif]

set lport [ipxact_create_logical_port -name CLK ]
set pport [ipxact_create_physical_port -name pclk ]
set pmap  [ipxact_create_portmap -logical $lport -physical $pport ]
set clk_bif [ipxact_bif_add_port_map -bif $clk_bif -pmap $pmap]

################### Create and add a memory map
set mmap [ ipxact_create_memory_map -name mmap1 -base_address 0x100 -bank_alignment_name bank_align1 -bank_alignment_type parallel -addr_blk_name blk1 -addr_blk_range 64K -addr_blk_width 32 -addr_bit_units 2048 -usage_type memory -access_type read_write -is_volatile]

set comp_tmp [ipxact_component_add_memory_map -component $comp -mmap $mmap]

set reg1 [ ipxact_create_register -name reg1 -offset 0 -size 32 -access_type read_write -reset_val 0xffffffff -reset_mask 0x0000f000 -is_volatile]
ipxact_set_description $reg1 "This is dummy description-1 for register"

set mmap [ ipxact_memory_map_add_register -mmap $mmap -addr_blk_name blk1  -register $reg1 ]


set field1 [ipxact_create_bit_field -name field1 -offset 2 -width 3 -access_type read_only]
ipxact_set_description $field1 "This is dummy description-1 for bit filed"
set field2 [ipxact_create_bit_field -name field2 -offset 7 -width 3 -access_type read_write_once ]
ipxact_set_description $field2 "This is dummy description-2 for bit filed"

set reg_tmp [ ipxact_register_add_bit_field -register $reg1 -bit_field $field1 ]
set reg_tmp [ ipxact_register_add_bit_field -register $reg1 -bit_field $field2 ]

set reg2 [ ipxact_create_register -name reg2 -offset 10 -size 32 -access_type read_write -reset_val 0x00000000 -reset_mask 0x0000ffff -is_volatile]

set mmap [ ipxact_memory_map_add_register -mmap $mmap -addr_blk_name blk1  -register $reg2 ]


############ end of memory map addition

################### Create and add a memory map
set mmap [ ipxact_create_memory_map -name mmap2 -base_address 0x200 -addr_blk_name blk2 -addr_blk_range 64K -addr_blk_width 32 -addr_bit_units 2048 -usage_type memory -access_type read_write ]

set comp_tmp [ipxact_component_add_memory_map -component $comp -mmap $mmap]

set reg1 [ ipxact_create_register -name reg2 -offset 2 -size 32 -access_type read_only -reset_val 0xffffffff -reset_mask 0x0000f00a ]

set mmap [ ipxact_memory_map_add_register -mmap $mmap -addr_blk_name blk2  -register $reg1 ]


set field1 [ipxact_create_bit_field -name field1 -offset 6 -width 1 -access_type read_only]
set field2 [ipxact_create_bit_field -name field2 -offset 8 -width 3 -access_type read_write_once ]
set reg_tmp [ ipxact_register_add_bit_field -register $reg1 -bit_field $field1 ]
set reg_tmp [ ipxact_register_add_bit_field -register $reg1 -bit_field $field2 ]
############ end of memory map addition

set comp [ ipxact_component_save -xml component.xml -component $comp]

