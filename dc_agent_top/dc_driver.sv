class dc_driver extends uvm_driver #(dc_xtn);
    `uvm_component_utils(dc_driver)

    dc_agent_config dc_cfg;
    virtual dc_if.dc_drv_mp vif;

    int line_count;
    function new(string name="dc_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
          if(!uvm_config_db #(dc_agent_config)::get(this,"","dc_agent_config",dc_cfg))
                `uvm_fatal(get_full_name(),"failed to get dc if")
    endfunction

     function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=dc_cfg.vif;
    endfunction
    task run_phase(uvm_phase phase);
        @(vif.dc_drv_cb);
        vif.dc_drv_cb.data_valid <= 1'b0;
        vif.dc_drv_cb.pixel_data <= '0;
        vif.dc_drv_cb.hsync      <= 1'b0;
        vif.dc_drv_cb.vsync      <= 1'b0;

        forever begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
    endtask

    task send_to_dut(dc_xtn xtn);
        /*
        `uvm_info(get_type_name(),
                  $sformatf("Driving DC transaction:\n%s", xtn.sprint()),
                  UVM_MEDIUM)

        if (xtn.pixel_data.size() == 0)
            `uvm_fatal(get_type_name(), "DC transaction contains no pixel data")

        foreach (xtn.pixel_data[i]) begin
            @(vif.dc_dc_drv_cb);
            vif.dc_dc_drv_cb.data_valid <= xtn.data_valid;
            vif.dc_dc_drv_cb.pixel_data <= xtn.pixel_data[i];
            vif.dc_dc_drv_cb.hsync      <= 1'b0;
            vif.dc_dc_drv_cb.vsync      <= 1'b0;
        end

        // A low data_valid cycle terminates this line for line_fifo.
        @(vif.dc_dc_drv_cb);
        vif.dc_dc_drv_cb.data_valid <= 1'b0;
        vif.dc_dc_drv_cb.pixel_data <= '0;

        // Let the DUT sample the end-of-line cycle before accepting another xtn.
        @(vif.dc_dc_drv_cb);
        */

         `uvm_info(get_type_name(),
                  $sformatf("Driving DC transaction:\n%s", xtn.sprint()),
                  UVM_MEDIUM)
      if(line_count == 0) begin //start of frame
        vif.dc_drv_cb.vsync <= 1'b1;
        vif.dc_drv_cb.hsync <= 1'b0;
        vif.dc_drv_cb.data_valid <= 1'b0;
        vif.dc_drv_cb.pixel_data <= 24'h0;
        
        repeat(xtn.vsa)
          @(vif.dc_drv_cb);
        
        vif.dc_drv_cb.vsync <= 1'b0;
        
        repeat(xtn.vbp) //vbp
          @(vif.dc_drv_cb);
      end
      
      vif.dc_drv_cb.hsync <= 1'b1; //HSYNC
      vif.dc_drv_cb.data_valid <= 1'b0;
      
      repeat(xtn.hsa)
        @(vif.dc_drv_cb);
      
      vif.dc_drv_cb.hsync <= 1'b0;
      
      repeat(xtn.hbp)
        @(vif.dc_drv_cb);
      
      foreach(xtn.pixel_data[i]) begin
        vif.dc_drv_cb.data_valid <= 1'b1;
        vif.dc_drv_cb.pixel_data <=xtn.pixel_data[i];
        @(vif.dc_drv_cb);
      end
      
      vif.dc_drv_cb.data_valid <= 1'b0;
      vif.dc_drv_cb.pixel_data <= 24'h0;
      
      repeat(xtn.hfp)
        @(vif.dc_drv_cb);
      
      line_count++;
      
      if(line_count == `hsync_cnt) begin //endof frame
       // `uvm_info(get_type_name(),$sformatf("lines are total now:%0d",line_count),UVM_MEDIUM)
        line_count = 0;
        repeat(xtn.vfp)
          @(vif.dc_drv_cb);
      end

    endtask

endclass
