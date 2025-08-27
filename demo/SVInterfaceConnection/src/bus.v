module bus(
        gclk,
        gresetn,
        cpu_resetn,
        cpu_clk,
        clk_phase,
        aid_audioout,
        axi_addr_audioout,
        avalid_audioout,
        awrite_audioout,
        alen_audioout,
        asize_audioout,
        aburst_audioout,
        rready_audioout,
        aready_audioout,
        rid_audioout,
        rdata_audioout,
        rlast_audioout,
        rvalid_audioout,
        aid_gdma,
        axi_addr_gdma,
        avalid_gdma,
        awrite_gdma,
        alen_gdma,
        asize_gdma,
        aburst_gdma,
        wid_gdma,
        wdata_gdma,
        wstrb_gdma,
        wlast_gdma,
        wvalid_gdma,
        rready_gdma,
        aready_gdma,
        wready_gdma,
        rid_gdma,
        rdata_gdma,
        rlast_gdma,
        rvalid_gdma,
        aid_demux,
        axi_addr_demux,
        avalid_demux,
        awrite_demux,
        alen_demux,
        asize_demux,
        aburst_demux,
        wid_demux,
        wdata_demux,
        wstrb_demux,
        wlast_demux,
        wvalid_demux,
        aready_demux,
        wready_demux,
        aid_ddr,
        axi_addr_ddr,
        avalid_ddr,
        awrite_ddr,
        alen_ddr,
        aburst_ddr,
        wid_ddr,
        wdata_ddr,
        wstrb_ddr,
        wlast_ddr,
        wvalid_ddr,
        rready_ddr,
        aready_ddr,
        wready_ddr,
        rid_ddr,
        rdata_ddr,
        rlast_ddr,
        rvalid_ddr,
        paddr,
        penable,
        pwrite,
        pwstrb,
        pwdata,
        prstrb,
        psel0,
        psel1,
        pready0,
        pready1,
        prdata0,
        prdata1,
        sram_cen,
        sram_wen,
        sram_addr,
        sram_datain,
        sram_dataout
    );
    input gclk;
    input gresetn;
    input cpu_resetn;
    input cpu_clk;
    input clk_phase;
    input [5:0]aid_audioout;
    input [31:0]axi_addr_audioout;
    input avalid_audioout;
    input awrite_audioout;
    output aready_audioout;
    input [3:0]alen_audioout;
    input [1:0]asize_audioout;
    input [1:0]aburst_audioout;
    output [5:0]rid_audioout;
    output [63:0]rdata_audioout;
    output rlast_audioout;
    output rvalid_audioout;
    input rready_audioout;
    input [5:0]aid_gdma;
    input [31:0]axi_addr_gdma;
    input avalid_gdma;
    input awrite_gdma;
    output aready_gdma;
    input [3:0]alen_gdma;
    input [1:0]asize_gdma;
    input [1:0]aburst_gdma;
    input [5:0]wid_gdma;
    input [63:0]wdata_gdma;
    input [7:0]wstrb_gdma;
    input wlast_gdma;
    input wvalid_gdma;
    output wready_gdma;
    output [5:0]rid_gdma;
    output [63:0]rdata_gdma;
    output rlast_gdma;
    output rvalid_gdma;
    input rready_gdma;
    input [5:0]aid_demux;
    input [31:0]axi_addr_demux;
    input avalid_demux;
    input awrite_demux;
    output aready_demux;
    input [3:0]alen_demux;
    input [1:0]asize_demux;
    input [1:0]aburst_demux;
    input [5:0]wid_demux;
    input [63:0]wdata_demux;
    input [7:0]wstrb_demux;
    input wlast_demux;
    input wvalid_demux;
    output wready_demux;
    output [5:0]aid_ddr;
    output [31:0]axi_addr_ddr;
    output avalid_ddr;
    output awrite_ddr;
    input aready_ddr;
    output [3:0]alen_ddr;
    output [1:0]aburst_ddr;
    output [5:0]wid_ddr;
    output [63:0]wdata_ddr;
    output [7:0]wstrb_ddr;
    output wlast_ddr;
    output wvalid_ddr;
    input wready_ddr;
    input [5:0]rid_ddr;
    input [63:0]rdata_ddr;
    input rlast_ddr;
    input rvalid_ddr;
    output rready_ddr;
    output [23:2]paddr;
    output penable;
    output pwrite;
    output [3:0]pwstrb;
    output [31:0]pwdata;
    output [3:0]prstrb;
    output psel0;
    output psel1;
    input pready0;
    input pready1;
    input [31:0]prdata0;
    input [31:0]prdata1;
    output sram_cen;
    output [7:0]sram_wen;
    output [9:0]sram_addr;
    output [63:0]sram_datain;
    input [63:0]sram_dataout;
endmodule 
