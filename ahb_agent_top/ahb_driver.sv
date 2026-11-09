class ahb_driver extends uvm_driver #(ahb_xtn);
    `uvm_component_utils(ahb_driver)

    ahb_agent_config ahb_cfg;
    virtual  ahb_if.ahb_drv_mp vif;
    function new(string name="ahb_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
          if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
                `uvm_fatal(get_full_name(),"failed to get ahb if")
    endfunction

     function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        vif=ahb_cfg.vif;
    endfunction

    task run_phase(uvm_phase phase);
        @(vif.ahb_drv_cb);
        vif.ahb_drv_cb.haddr  <= '0;
        vif.ahb_drv_cb.hwrite <= 1'b0;
        vif.ahb_drv_cb.hburst <= '0;
        vif.ahb_drv_cb.hsize  <= '0;
        vif.ahb_drv_cb.htrans <= 2'b00;
        vif.ahb_drv_cb.hprot  <= '0;
        vif.ahb_drv_cb.hwdata <= '0;

        forever begin
            seq_item_port.get_next_item(req);
            send_to_dut(req);
            seq_item_port.item_done();
        end
    endtask

    task send_to_dut(ahb_xtn xtn);
        `uvm_info(get_type_name(),
                  $sformatf("Driving AHB transaction:\n%s", xtn.sprint()),
                  UVM_MEDIUM)

        @(vif.ahb_drv_cb);
        while (vif.ahb_drv_cb.hready !== 1'b1 && vif.ahb_drv_cb.hresetn!==1)
            @(vif.ahb_drv_cb);

        // Drive address/control first; HWDATA belongs to the next AHB phase.
        vif.ahb_drv_cb.haddr  <= xtn.haddr;
        vif.ahb_drv_cb.hwrite <= xtn.hwrite;
        vif.ahb_drv_cb.hburst <= xtn.hburst;
        vif.ahb_drv_cb.hsize  <= xtn.hsize;
        vif.ahb_drv_cb.htrans <= xtn.htrans;
        vif.ahb_drv_cb.hprot  <= xtn.hprot;

        @(vif.ahb_drv_cb);
        while (vif.ahb_drv_cb.hready !== 1'b1)
            @(vif.ahb_drv_cb);
        vif.ahb_drv_cb.hwdata <= xtn.hwdata;
        vif.ahb_drv_cb.hwrite <= 1'b0;
        vif.ahb_drv_cb.htrans <= 2'b00;

        @(vif.ahb_drv_cb);
        while (vif.ahb_drv_cb.hready !== 1'b1)
            @(vif.ahb_drv_cb);
        vif.ahb_drv_cb.hwdata <= '0;
    endtask

endclass
