module dmx(
        rst_n,
        dmx_clk,
        gresetn,
        gclk,
        presetn,
        pclk,
        clk_phase,
        ts_clk_a,
        fr_ts_sync_a,
        fr_ts_dvalid_a,
        fr_ts_di_a,
        fr_ts_derr_a,
        penable,
        psel,
        pwrite,
        paddr,
        pwdata,
        prdata,
        pready,
        aready_dmx,
        aid_dmx,
        axi_addr_dmx,
        avalid_dmx,
        awrite_dmx,
        alen_dmx,
        aburst_dmx,
        asize_dmx,
        wready_dmx,
        wid_dmx,
        wdata_dmx,
        wstrb_dmx,
        wlast_dmx,
        wvalid_dmx,
        out_int
    );
    input rst_n;
    input dmx_clk;
    input gresetn;
    input gclk;
    input presetn;
    input pclk;
    input clk_phase;
    input ts_clk_a;
    input fr_ts_sync_a;
    input fr_ts_dvalid_a;
    input [7:0]fr_ts_di_a;
    input fr_ts_derr_a;
    input penable;
    input psel;
    input pwrite;
    input [13:2]paddr;
    input [31:0]pwdata;
    output [31:0]prdata;
    output pready;
    input aready_dmx;
    output [5:0]aid_dmx;
    wire [5:0]aid_dmx;
    output [31:0]axi_addr_dmx;
    output avalid_dmx;
    output awrite_dmx;
    output [3:0]alen_dmx;
    output [1:0]aburst_dmx;
    output [1:0]asize_dmx;
    input wready_dmx;
    output [5:0]wid_dmx;
    wire [5:0]wid_dmx;
    output [63:0]wdata_dmx;
    output [7:0]wstrb_dmx;
    output wlast_dmx;
    output wvalid_dmx;
    output out_int;
endmodule
