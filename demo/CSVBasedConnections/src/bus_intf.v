
interface bus_intf;
    wire [31:0] data;
    logic [15:0] address;
    logic request;
    logic grant;
    logic ready;

    modport master(
                inout data,
                output address,
                output request,
                input grant,
                input ready 
            );

    modport slave(
                inout data,
                input address,
                input request,
                output grant,
                output ready 
            );

endinterface

