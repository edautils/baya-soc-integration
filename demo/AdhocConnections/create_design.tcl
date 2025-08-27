## The object $baya is already defined/created above.
## We need tto just invoke the APIs of the $baya to create
## top design i.e. SoC or sub-system

baya_set_file -name system1.v

set socname  Leon2Platform

############ Create the top DUT
baya_create_module -name $socname 

#### Create port of the DUT
baya_create_port -name logic_zero -dir in -range 15:0
baya_create_port -name clkin -dir in
baya_create_port -name rstin_an -dir in
baya_create_port -name SimDone -dir out 
#### Import the designs
baya_import_vhdl -file ./RTL_COMP/leon2Ahbram.vhd -top leon2Ahbram
#$baya importVHDLEntity ./RTL_COMP/leon2Ahbbus22.vhd leon2Ahbbus22
baya_import_ipxact -xml XML_COMP/ahbbus22.xml
baya_import_vhdl -file ./RTL_COMP/apbSubSystem_ent.vhd -top apbSubSystem
baya_import_vhdl -file ./RTL_COMP/cgu.vhd -top cgu
baya_import_vhdl -file ./RTL_COMP/leon2Dma.vhd -top leon2Dma
baya_import_vhdl -file ./RTL_COMP/processor.vhd -top processor
baya_import_vhdl -file ./RTL_COMP/rgu.vhd -top rgu


############ Set the currrent design to the top DUT

baya_set_current_module -name $socname

#### Create instances of each of the imported  components and the param maps
## The leon2Ahbbus22 is defined in RTL
## The ahbbus22 is defined in the IPXACT comp file
baya_create_parameter -name myParam -value 2 
### This parameter will get created
###in the module current module which we have set with 
### the baya_set_current_module command as above

baya_create_instance -name uahbbus -master ahbbus22
### The instances will get created in the current moduel as we have set before

baya_create_parameter_map -inst uahbbus -param start_addr_slv0 -value 0
baya_create_parameter_map -inst uahbbus -param restart_addr_slv0 -value 0
baya_create_parameter_map -inst uahbbus -param range_slv0 -value 1048576
baya_create_parameter_map -inst uahbbus -param mst_access_slv0 -value 3
baya_create_parameter_map -inst uahbbus -param start_addr_slv1 -value 12288
baya_create_parameter_map -inst uahbbus -param restart_addr_slv1 -value 12288
baya_create_parameter_map -inst uahbbus -param range_slv1 -value 36864
baya_create_parameter_map -inst uahbbus -param mst_access_slv1 -value myParam+1
baya_create_parameter_map -inst uahbbus -param defmast -value 1

baya_create_instance -name uahbram  -master leon2Ahbram
baya_create_parameter_map -inst uahbram -param abits -value 20

baya_create_instance -name uapbSubSystem  -master apbSubSystem

baya_create_instance -name ucgu -master cgu

baya_create_instance -name  udma -master leon2Dma

baya_create_instance -name  uproc -master processor

baya_create_parameter_map -inst uproc -param local_memory_start_addr -value 16'h1000

baya_create_parameter_map -inst uproc -param local_memory_addr_bits  -value 12

baya_create_instance -name  urgu -master rgu

#### Create connections

### You need to specify the bit/part selectsa otherwise Tcl will
### evaluate that as an Tcl expression since the operator is '[]'

### Connect the ground zero
baya_add_connection -src logic_zero -dest uahbbus.remap
baya_add_connection -src logic_zero -dest uahbbus.hlock_mst0
baya_add_connection -src logic_zero\[15:0\] -dest uahbbus.hsplit_slv1
#### Trying by providing range with the () instead of []
baya_add_connection -src logic_zero(0) -dest uproc.clkn
baya_add_connection -src logic_zero(0) -dest uproc.tck
baya_add_connection -src logic_zero(0) -dest uproc.ntrst
baya_add_connection -src logic_zero(0) -dest uproc.tms
baya_add_connection -src logic_zero(0) -dest uproc.tdi

### Connect the reset
baya_add_connection -src urgu.rstout_an(0) -dest urgu.presetn
baya_add_connection -src urgu.rstout_an(0) -dest uahbbus.rst 
baya_add_connection -src urgu.rstout_an(0) -dest uahbram.rst
baya_add_connection -src urgu.rstout_an(0) -dest uapbSubSystem.rst_an
baya_add_connection -src urgu.rstout_an(0) -dest ucgu.presetn
baya_add_connection -src urgu.rstout_an(0) -dest udma.rst
baya_add_connection -src urgu.rstout_an(0) -dest uproc.presetn
baya_add_connection -src urgu.rstout_an(0) -dest uproc.hresetn
baya_add_connection -src urgu.rstout_an(1) -dest uproc.rst_an

### Connect the clock
baya_add_connection -src ucgu.clkout(0) -dest uahbbus.clk
baya_add_connection -src ucgu.clkout(0) -dest ucgu.pclk
baya_add_connection -src ucgu.clkout(0) -dest uahbram.clk
baya_add_connection -src ucgu.clkout(0) -dest uapbSubSystem.clk
baya_add_connection -src ucgu.clkout(0) -dest udma.clk
baya_add_connection -src ucgu.clkout(0) -dest uproc.pclk
baya_add_connection -src ucgu.clkout(0) -dest uproc.hclk
baya_add_connection -src ucgu.clkout(0) -dest urgu.pclk
baya_add_connection -src ucgu.prdata -dest uapbSubSystem.i_apbbus_slv4_prdata

## Connect the hgrants of the bus 
baya_add_connection -src uahbbus.hgrant_mst0 -dest uproc.hgrant
baya_add_connection -src uahbbus.hgrant_mst1 -dest udma.hgrant

## Connect the hready of the bus 
baya_add_connection -src uahbbus.hready_mst0 -dest uproc.hready
baya_add_connection -src uahbbus.hready_mst1 -dest udma.hready

## Connect the hresp of the bus 
baya_add_connection -src uahbbus.hresp_mst0 -dest uproc.hresp
baya_add_connection -src uahbbus.hresp_mst1 -dest udma.hresp

## Connect the hrdata of the bus 
baya_add_connection -src uahbbus.hrdata_mst0 -dest uproc.hrdata
baya_add_connection -src uahbbus.hrdata_mst1 -dest udma.hrdata

## Connect the busreq of the bus 
baya_add_connection -src uproc.hbusreq -dest uahbbus.hbusreq_mst0
baya_add_connection -src udma.hbusreq -dest uahbbus.hbusreq_mst1

## Connect the htrans of the bus 
baya_add_connection -src udma.htrans -dest uahbbus.htrans_mst1
baya_add_connection -src uproc.htrans -dest uahbbus.htrans_mst0

## Other connections
baya_add_connection -src uproc.hwrite -dest uahbbus.hwrite_mst0
baya_add_connection -src uproc.hsize -dest uahbbus.hsize_mst0
baya_add_connection -src uproc.hburst -dest uahbbus.hburst_mst0
baya_add_connection -src uproc.hprot -dest uahbbus.hprot_mst0
baya_add_connection -src uproc.haddr -dest uahbbus.haddr_mst0
baya_add_connection -src uproc.hwdata -dest uahbbus.hwdata_mst0
baya_add_connection -src uproc.prdata -dest uapbSubSystem.i_apbbus_slv6_prdata
baya_add_connection -src uproc.intack -dest uapbSubSystem.Interrupt_INTack
baya_add_connection -src uproc.irqvec -dest uapbSubSystem.Interrupt_IRQVEC
baya_add_connection -src uproc.SimDone -dest SimDone

baya_add_connection -src uapbSubSystem.i_apbbus_slv6_psel -dest uproc.psel
baya_add_connection -src uapbSubSystem.i_apbbus_slv6_penable -dest uproc.penable
baya_add_connection -src uapbSubSystem.i_apbbus_slv6_paddr\[11:0\] -dest uproc.paddr
baya_add_connection -src uapbSubSystem.i_apbbus_slv6_pwrite -dest uproc.pwrite
baya_add_connection -src uapbSubSystem.i_apbbus_slv6_pwdata -dest uproc.pwdata
baya_add_connection -src uapbSubSystem.Interrupt_IRL -dest uproc.irl
baya_add_connection -src uapbSubSystem.i_apbbus_slv5_paddr -dest urgu.paddr\[11:0\]
baya_add_connection -src uapbSubSystem.i_apbbus_slv5_pwrite -dest urgu.pwrite
baya_add_connection -src urgu.prdata -dest uapbSubSystem.i_apbbus_slv5_prdata

baya_add_connection -src udma.hwrite -dest uahbbus.hwrite_mst1
baya_add_connection -src udma.hsize -dest uahbbus.hsize_mst1
baya_add_connection -src udma.hburst -dest uahbbus.hburst_mst1
baya_add_connection -src udma.hprot -dest uahbbus.hprot_mst1
baya_add_connection -src udma.hwdata -dest uahbbus.hwdata_mst1
baya_add_connection -src udma.prdata -dest uapbSubSystem.i_apbbus_slv7_prdata
baya_add_connection -src udma.haddr -dest uahbbus.haddr_mst1

baya_add_connection -src uapbSubSystem.i_apbbus_slv7_pwdata -dest udma.pwdata 
baya_add_connection -src uapbSubSystem.i_apbbus_slv7_pwrite -dest udma.pwrite 
baya_add_connection -src uapbSubSystem.i_apbbus_slv7_paddr -dest udma.paddr 
baya_add_connection -src uapbSubSystem.i_apbbus_slv7_penable -dest udma.penable 
baya_add_connection -src uapbSubSystem.i_apbbus_slv7_psel -dest udma.psel 
baya_add_connection -src uapbSubSystem.i_apbbus_slv4_pwdata -dest ucgu.pwdata 
baya_add_connection -src uapbSubSystem.i_apbbus_slv4_pwrite -dest ucgu.pwrite 
#### Trying by providing range with the () instead of []
baya_add_connection -src uapbSubSystem.i_apbbus_slv4_paddr(11:0) -dest ucgu.paddr 
baya_add_connection -src uapbSubSystem.i_apbbus_slv4_penable -dest ucgu.penable 
baya_add_connection -src uapbSubSystem.i_apbbus_slv4_psel -dest ucgu.psel 


baya_add_connection -src uahbbus.hwrite_slv1 -dest uapbSubSystem.ex_ambaAHB_hwrite
baya_add_connection -src uahbbus.hwdata_slv1 -dest uapbSubSystem.ex_ambaAHB_hwdata
baya_add_connection -src uahbbus.htrans_slv1 -dest uapbSubSystem.ex_ambaAHB_htrans
baya_add_connection -src uahbbus.hsize_slv1 -dest uapbSubSystem.ex_ambaAHB_hsize
baya_add_connection -src uahbbus.hsel_slv1 -dest uapbSubSystem.ex_ambaAHB_hsel
baya_add_connection -src uapbSubSystem.ex_ambaAHB_hresp -dest uahbbus.hresp_slv1

baya_add_connection -src uahbbus.hprot_slv1 -dest uapbSubSystem.ex_ambaAHB_hprot
baya_add_connection -src uahbbus.hburst_slv1 -dest uapbSubSystem.ex_ambaAHB_hburst
baya_add_connection -src uahbbus.haddr_slv1 -dest uapbSubSystem.ex_ambaAHB_haddr

baya_add_connection -src uapbSubSystem.ex_ambaAHB_hready_resp -dest uahbbus.hreadyout_slv1
baya_add_connection -src uapbSubSystem.ex_ambaAHB_hrdata -dest uahbbus.hrdata_slv1

baya_add_connection -src uahbram.hsplit_s -dest uahbbus.hsplit_slv0
baya_add_connection -src uahbram.hrdata_s -dest uahbbus.hrdata_slv0
baya_add_connection -src uahbram.hresp_s -dest uahbbus.hresp_slv0
baya_add_connection -src uahbram.hreadyo_s -dest uahbbus.hreadyout_slv0

baya_add_connection -src uahbbus.hmastlock_slv0 -dest uahbram.hmastlock_s
baya_add_connection -src uahbbus.hreadyin_slv0 -dest uahbram.hreadyi_s
baya_add_connection -src uahbbus.hprot_slv0 -dest uahbram.hprot_s
baya_add_connection -src uahbbus.hwdata_slv0 -dest uahbram.hwdata_s
baya_add_connection -src uahbbus.hburst_slv0 -dest uahbram.hburst_s
baya_add_connection -src uahbbus.hsize_slv0 -dest uahbram.hsize_s
baya_add_connection -src uahbbus.htrans_slv0 -dest uahbram.htrans_s
baya_add_connection -src uahbbus.hwrite_slv0 -dest uahbram.hwrite_s
baya_add_connection -src uahbbus.haddr_slv0 -dest uahbram.haddr_s
baya_add_connection -src uahbbus.hsel_slv0 -dest uahbram.hsel_s

baya_elaborate -module  $socname
 
set str [baya_print_verilog -module $socname]

puts $str

baya_set_file -name system1.v
baya_print_verilog_file -module $socname

