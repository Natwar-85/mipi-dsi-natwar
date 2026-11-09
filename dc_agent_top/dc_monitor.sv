class dc_monitor extends uvm_sequencer ;
    `uvm_component_utils(dc_monitor)

    dc_agent_config dc_cfg;
    virtual dc_if.dc_mon_mp vif;
    uvm_analysis_port #(dc_xtn) dc_port;

    function new(string name="dc_mon",uvm_component parent);
        super.new(name,parent);
    endfunction

    
    function void build_phase(uvm_phase phase);
          dc_port=new("dc_mon_port",this);
          if(!uvm_config_db #(dc_agent_config)::get(this,"","dc_agent_config",dc_cfg))
          `uvm_fatal(get_full_name(),"failed to get dc if")
    endfunction

     function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=dc_cfg.vif;
    endfunction


    task run_phase(uvm_phase phase);
    dc_xtn item;
    int count;

    forever begin

      item = dc_xtn::type_id::create("mon_item");
      item.data_valid = vif.dc_mon_cb.data_valid;
      item.pixel_data = new[`payload_cnt];
      count = 0;
      while (count < `payload_cnt) begin
        @(vif.dc_mon_cb);
        if (vif.dc_mon_cb.data_valid) begin
          item.pixel_data[count] = vif.dc_mon_cb.pixel_data;
       //   `uvm_info(get_full_name(),$sformatf("moh transaction items are:",item.sprint()),UVM_LOW)
          count=count+1;
        end
      end

   //  `uvm_info("DC_MON",$sformatf("DC transaction captured: %0d pixels",
     //                             count),UVM_MEDIUM)
      
      dc_port.write(item);
    end
  endtask
endclass
