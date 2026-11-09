class ppi_agent extends uvm_agent;
    `uvm_component_utils(ppi_agent)


ppi_monitor monh;

ppi_agent_config ppi_cfg;

function new(string name="ppi_agent",uvm_component parent);
        super.new(name,parent);
endfunction



function void build_phase(uvm_phase phase);


        super.build_phase(phase);
       // ppi_cfg=ppi_agent_config::type_id::create("ppi-cfg");
        if(!uvm_config_db #(ppi_agent_config)::get(this,"","ppi_agent_config",ppi_cfg))
        `uvm_fatal(get_full_name(),"to get ppi agent config")

        monh=ppi_monitor::type_id::create("ppi_mon",this);
        /*if(ppi_cfg.is_active)
        begin
        drvh=ppi_driver::type_id::create("ppi_drv",this);
        seqrh=ppi_sequencer::type_id::create("ppi_seqr",this);
        end
        */
endfunction

function void connect_phase(uvm_phase phase);
      //  drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction


endclass


