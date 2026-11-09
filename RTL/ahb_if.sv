interface ahb_if(input bit clk,input bit hresetn);

 
  logic  [31:0] haddr;
  logic [2:0] hsize;
  logic  [31:0] hwdata;
  logic hwrite;
 
  logic [1:0] htrans; 
  logic [2:0] hburst;
  logic [3:0] hprot;

logic hready;
logic [1:0] hresp;
logic [31:0] hrdata;


clocking ahb_drv_cb @(posedge clk);
		default input #1 output #1;

    output haddr;
    output hsize;
    output hwdata;
    output hwrite;
 
    output htrans; 
    output hburst;
    output  hprot;
    input  hready;
    input hresp;
    input hrdata;
    input hresetn;
endclocking

clocking ahb_mon_cb @(posedge clk);
    input haddr;
    input hsize;
    input hwdata;
    input hwrite;
 
    input htrans; 
    input hburst;
    input hprot;
    input hready;
    input hresp;
    input hrdata;
    input hresetn;
endclocking

modport ahb_drv_mp(clocking ahb_drv_cb);
modport ahb_mon_mp(clocking ahb_mon_cb);

endinterface