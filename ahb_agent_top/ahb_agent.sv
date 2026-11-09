class ahb_agent extends uvm_agent;
    `uvm_component_utils(ahb_agent)

   

ahb_monitor monh;
ahb_driver drvh;
ahb_seqr seqrh;

ahb_agent_config ahb_cfg;

function new(string name="ahb_agent",uvm_component parent);
        super.new(name,parent);
endfunction



function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        begin
        //ahb_cfg=ahb_agent_config::type_id::create("ahb_cfg");
        if(!uvm_config_db #(ahb_agent_config)::get(this,"","ahb_agent_config",ahb_cfg))
        `uvm_fatal(get_full_name(),"to get ahb agent config")

        monh=ahb_monitor::type_id::create("ahb_mon",this);
       if(ahb_cfg.is_active)
        begin
        drvh=ahb_driver::type_id::create("ahb_drv",this);
        seqrh=ahb_seqr::type_id::create("ahb_seqr",this);
        end
        end
endfunction

function void connect_phase(uvm_phase phase);
        drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction


endclass



