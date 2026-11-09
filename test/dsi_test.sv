class dsi_test extends uvm_test;

    ahb_agent_config  ahb_cfg;
    dc_agent_config dc_cfg;
    ppi_agent_config ppi_cfg;

    int has_ahb_agent=1;
    int has_dc_agent=1;
    int has_ppi_agent=1;

    dsi_env_config env_cfg;

    `uvm_component_utils(dsi_test)
    dsi_env envh;
    function new(string name="dsi_test",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
    begin
        super.build_phase(phase);
        envh=dsi_env::type_id::create("envh",this);
        env_cfg=dsi_env_config::type_id::create("env_cfg");

            if(has_ahb_agent)
                begin
                ahb_cfg=ahb_agent_config::type_id::create("ahb_cfg");
                if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_if",ahb_cfg.vif))
                `uvm_fatal(get_full_name(),"failed to get ahb if")
                ahb_cfg.is_active=UVM_ACTIVE;
                env_cfg.ahb_cfg=ahb_cfg;
                end

             if(has_dc_agent)
                begin
                dc_cfg=dc_agent_config::type_id::create("dc_cfg");
                if(!uvm_config_db #(virtual dc_if)::get(this,"","dc_if",dc_cfg.vif))
                `uvm_fatal(get_full_name(),"failed to get dc if")
                dc_cfg.is_active=UVM_ACTIVE;
                env_cfg.dc_cfg=dc_cfg;
                end


             if(has_ppi_agent)
                begin
                ppi_cfg=ppi_agent_config::type_id::create("ppi_cfg");
                  if(!uvm_config_db #(virtual ppi_if)::get(this,"","ppi_if",ppi_cfg.vif))
                `uvm_fatal(get_full_name(),"failed to get ppi if")
                ppi_cfg.is_active=UVM_PASSIVE;
                env_cfg.ppi_cfg=ppi_cfg;
                end

                uvm_config_db #(dsi_env_config)::set(this,"*","dsi_env_config",env_cfg);



    end
    endfunction


    function void end_of_elaboration_phase(uvm_phase phase);
     //super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
    endtask   
endclass

// to run ahb logic ***********************************************************
class ahb_test extends dsi_test;
    `uvm_component_utils(ahb_test)

    ahb_seqs seq;
    function new(string name="ahb_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        ahb_seqs seq;

        phase.raise_objection(this);
        seq = ahb_seqs::type_id::create("seq");
        seq.start(envh.ahb_agenth.seqrh);
        #1000_00;
        phase.drop_objection(this);
    endtask
endclass

// Test that drives the display-controller pixel stream.
class dc_test extends dsi_test;
    `uvm_component_utils(dc_test)

    function new(string name="dc_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    task run_phase(uvm_phase phase);
        dc_seqs seq;

        phase.raise_objection(this);
        seq = dc_seqs::type_id::create("dc_seqsgf");
        seq.start(envh.dc_agenth.seqrh);
        phase.drop_objection(this);
    endtask
endclass

// Stimulates the DUT through AHB and DC while the PPI monitor observes output.
class ppi_test extends dsi_test;
    `uvm_component_utils(ppi_test)

    function new(string name="ppi_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        ahb_seqs ahb_seq;
        dc_seqs dc_seq;

        phase.raise_objection(this);
        ahb_seq = ahb_seqs::type_id::create("ahb_seq");
        dc_seq = dc_seqs::type_id::create("dc_seq");

        fork
            ahb_seq.start(envh.ahb_agenth.seqrh);
            dc_seq.start(envh.dc_agenth.seqrh);
            #5000_000;
        join

        phase.drop_objection(this);
    endtask
endclass
