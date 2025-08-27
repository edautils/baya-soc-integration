interface axi_bus
(input wire clk,reset_n);
logic	[ 5:0]	aid;
logic	[31:0]	aaddr;
logic			avalid;
logic			awrite;
logic	[ 3:0]	alen;
logic	[ 1:0]	asize;
logic	[ 1:0]	aburst;
logic			aready;
logic	[ 5:0]	wid;
logic	[63:0]	wdata;
logic	[ 7:0]	wstrb;
logic			wlast;
logic			wvalid;
logic			wready;
logic	[ 5:0]	rid;
logic	[63:0]	rdata;
logic			rlast;
logic			rvalid;
logic			rready;

modport axi_slave_ar	(	input	aid,aaddr,avalid,awrite,alen,asize,aburst,rready,
							output	aready,rid,rdata,rlast,rvalid);
modport axi_master_ar	(	output	aid,aaddr,avalid,awrite,alen,asize,aburst,rready,
							input	aready,rid,rdata,rlast,rvalid);
modport axi_slave_aw	(	input	aid,aaddr,avalid,awrite,alen,asize,aburst,
									wid,wdata,wstrb,wlast,wvalid,
							output	aready,wready);
modport axi_master_aw	(	output	aid,aaddr,avalid,awrite,alen,asize,aburst,
									wid,wdata,wstrb,wlast,wvalid,
							input	aready,wready);
modport axi_slave		(	input	aid,aaddr,avalid,awrite,alen,asize,aburst,
									wid,wdata,wstrb,wlast,wvalid,rready,
							output	aready,wready,rid,rdata,rlast,rvalid);
modport axi_master		(	output	aid,aaddr,avalid,awrite,alen,asize,aburst,
									wid,wdata,wstrb,wlast,wvalid,rready,
							input	aready,wready,rid,rdata,rlast,rvalid);
endinterface


