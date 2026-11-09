class ppi_monitor extends uvm_monitor;
    `uvm_component_utils(ppi_monitor)

    uvm_analysis_port #(ppi_xtn) ppi_port;
    ppi_agent_config ppi_cfg;
    virtual ppi_if.ppi_mon_mp vif;

    ppi_xtn tx;
    function new(string name="ppi_mon",uvm_component parent);
        super.new(name,parent);
    endfunction

    
    function void build_phase(uvm_phase phase);
        ppi_port=new("ppi_port",this);
          if(!uvm_config_db #(ppi_agent_config)::get(this,"","ppi_agent_config",ppi_cfg))
                `uvm_fatal(get_full_name(),"failed to get ppi if")
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=ppi_cfg.vif;
    endfunction

    task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      tx = ppi_xtn::type_id::create("ppi_mon_tx");
      @(vif.ppi_mon_cb);
      
      if (vif.ppi_mon_cb.ppi_lane0_en) begin
        tx.ppi_data_lane0 =vif.ppi_mon_cb.ppi_data_lane0;
        tx.ppi_lane0_en =vif.ppi_mon_cb.ppi_lane0_en;
      end
      else begin
        tx.ppi_data_lane0 = 0;
        tx.ppi_lane0_en   = 0;
      end
      
      if (vif.ppi_mon_cb.ppi_lane1_en) begin
        tx.ppi_data_lane1 =vif.ppi_mon_cb.ppi_data_lane1;
        tx.ppi_lane1_en =vif.ppi_mon_cb.ppi_lane1_en;
      end
      else begin
        tx.ppi_data_lane1 = 0;
        tx.ppi_lane1_en   = 0;
      end
      
      if (vif.ppi_mon_cb.ppi_lane2_en) begin
        tx.ppi_data_lane2 =vif.ppi_mon_cb.ppi_data_lane2;
        tx.ppi_lane2_en =vif.ppi_mon_cb.ppi_lane2_en;
      end
      else begin
        tx.ppi_data_lane2 = 0;
        tx.ppi_lane2_en   = 0;
      end
      
      if (vif.ppi_mon_cb.ppi_lane3_en) begin
        tx.ppi_data_lane3 =
            vif.ppi_mon_cb.ppi_data_lane3;

        tx.ppi_lane3_en =
            vif.ppi_mon_cb.ppi_lane3_en;

      end
      else begin
        tx.ppi_data_lane3 = '0;
        tx.ppi_lane3_en   = 0;
      end
      
      if (tx.ppi_lane0_en ||
          tx.ppi_lane1_en ||
          tx.ppi_lane2_en ||
          tx.ppi_lane3_en) begin
      //  `uvm_info(get_full_name(),$sformatf("PPI lanes: L0=%02h L1=%02h L2=%02h L3=%02h | EN=%0b%0b%0b%0b",tx.ppi_data_lane0,tx.ppi_data_lane1,
        //                              tx.ppi_data_lane2,tx.ppi_data_lane3,
          //                            tx.ppi_lane3_en,
            //                          tx.ppi_lane2_en,
              //                        tx.ppi_lane1_en,
                //                      tx.ppi_lane0_en),UVM_LOW)
        ppi_port.write(tx);
      end
    end
  endtask
  
endclass
