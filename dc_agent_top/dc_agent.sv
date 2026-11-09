class dc_agent extends uvm_agent;
    `uvm_component_utils(dc_agent)


dc_monitor monh;
dc_driver drvh;
dc_seqr seqrh;

dc_agent_config dc_cfg;

function new(string name="dc_agent",uvm_component parent);
        super.new(name,parent);
endfunction



function void build_phase(uvm_phase phase);

      //  dc_cfg=dc_agent_config::type_id::create("dc_cfg");
        super.build_phase(phase);
        if(!uvm_config_db #(dc_agent_config)::get(this,"","dc_agent_config",dc_cfg))
        `uvm_fatal(get_full_name(),"to get dc agent config")

        monh=dc_monitor::type_id::create("dc_mon",this);
        if(dc_cfg.is_active)
        begin
        drvh=dc_driver::type_id::create("dc_drv",this);
        seqrh=dc_seqr::type_id::create("dc_seqr",this);
        end

endfunction

function void connect_phase(uvm_phase phase);
        drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction


endclass

