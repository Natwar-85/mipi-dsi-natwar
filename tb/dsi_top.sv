module top();

 import uvm_pkg::*;

`include "uvm_macros.svh"
 import dsi_pkg::*;
 bit dsi_clk;
 bit hrstn;
 bit hclk=1'b0;

 ahb_if ahb_vif(hclk,hrstn);
 dc_if dc_vif(hclk);
 ppi_if ppi_vif(dsi_clk);


 dsi #(10, 5) dut(.haddr(ahb_vif.haddr),
  								.hwrite(ahb_vif.hwrite), 
                                .hsize(ahb_vif.hsize),   
                                .hburst(ahb_vif.hburst),
                                .htrans(ahb_vif.htrans),
                                .hwdata(ahb_vif.hwdata),
                                .hprot(ahb_vif.hprot),
                                .hresp(ahb_vif.hresp),
  		                        .hready(ahb_vif.hready),
                                .hrdata(ahb_vif.hrdata),
                                                      
                                .pixel_data(dc_vif.pixel_data),
  		                        .data_valid(dc_vif.data_valid),
  		                        .hsync(dc_vif.hsync),
  	                            .vsync(dc_vif.vsync),
                                .pclk(hclk),
                                                       
                                .dsi_rst(hrstn),
                                .dsi_clk(dsi_clk),
                                .ppi_data_lane0(ppi_vif.ppi_data_lane0),
                                .ppi_data_lane1(ppi_vif.ppi_data_lane1),
                                .ppi_data_lane2(ppi_vif.ppi_data_lane2),
                                .ppi_data_lane3(ppi_vif.ppi_data_lane3),


                                .ppi_lane0_en(ppi_vif.ppi_lane0_en),
                                .ppi_lane1_en(ppi_vif.ppi_lane1_en),
                                .ppi_lane2_en(ppi_vif.ppi_lane2_en),
                                .ppi_lane3_en(ppi_vif.ppi_lane3_en)
                                                     );
//import dsi_pkg::*;

always #5 hclk=~hclk;

initial 
begin 
    hrstn<=0;
    @(negedge hclk);
    hrstn<=1;
end




initial 
    begin
        uvm_config_db #(virtual ahb_if)::set(null,"*","ahb_if",ahb_vif);
        uvm_config_db #(virtual dc_if)::set(null,"*","dc_if",dc_vif);
        uvm_config_db #(virtual ppi_if)::set(null,"*","ppi_if",ppi_vif); 
        run_test();
    end

endmodule