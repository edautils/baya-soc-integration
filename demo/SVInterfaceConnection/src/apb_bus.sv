interface apb_bus
(input wire clk,reset_n);
logic	[23:2]	paddr;
logic			penable;
logic			pwrite;
logic	[31:0]	pwdata;
logic			psel;
logic			pready;
logic	[31:0]	prdata;

modport apb_master1	(	output	paddr,penable,pwrite,pwdata);
modport apb_slave1	(	input	paddr,penable,pwrite,pwdata);
modport apb_master2	(	output	psel,
						input	pready,prdata);
modport apb_slave2	(	input	psel,
						output	pready,prdata);

endinterface
