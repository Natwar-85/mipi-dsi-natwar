interface ppi_if(input bit clk);
        logic [7:0] ppi_data_lane0;
        logic [7:0] ppi_data_lane1;
        logic [7:0] ppi_data_lane2;
        logic [7:0] ppi_data_lane3;

        logic ppi_lane0_en;
        logic ppi_lane1_en;
        logic ppi_lane2_en;
        logic ppi_lane3_en;



    clocking ppi_mon_cb @(posedge clk);
        input ppi_data_lane0;
        input ppi_data_lane1;
        input ppi_data_lane2;
        input ppi_data_lane3;

        input ppi_lane0_en;
        input ppi_lane1_en;
        input ppi_lane2_en;
        input ppi_lane3_en;

    endclocking
      modport ppi_mon_mp(clocking ppi_mon_cb);
endinterface