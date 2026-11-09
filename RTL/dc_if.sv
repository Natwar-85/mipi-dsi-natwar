interface dc_if(input bit clk);
    logic data_valid;
    logic  [23:0] pixel_data;
    logic hsync;
    logic vsync;

    clocking dc_drv_cb @(posedge clk);
        output data_valid;
        output pixel_data;
        output hsync;
        output vsync;
    endclocking


    clocking dc_mon_cb @(posedge clk);
        input data_valid;
        input pixel_data;
        input hsync;
        input vsync;
    endclocking

    modport dc_drv_mp(clocking dc_drv_cb);
    modport dc_mon_mp(clocking dc_mon_cb);
endinterface