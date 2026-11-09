class dsi_env extends uvm_env;

  `uvm_component_utils(dsi_env)

  ahb_agent ahb_agenth;
  dc_agent  dc_agenth;
  ppi_agent ppi_agenth;
  dsi_scoreboard scoreboard;
  dsi_env_config env_cfg;
  /*
  ahb_agent_config ahb_cfg;
  dc_agent_config dc_cfg;
  ppi_agent_config ppi_cfg;
*/
  //mipi_ahb_cov ahb_cov;
  //mipi_dc_cov dc_cov;
    //mipi_ppi_cov ppi_cov;
  
  function new(string name="dsi_env",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //env_cfg=dsi_env_config::type_id::create("env_cfg");
    if(!uvm_config_db #(dsi_env_config)::get(this,"","dsi_env_config",env_cfg))
        `uvm_fatal(get_full_name(),"to get env config ")

    if(env_cfg.has_ahb_agent)
    begin
      
      uvm_config_db #(ahb_agent_config)::set(this,"*","ahb_agent_config",env_cfg.ahb_cfg);
      ahb_agenth =ahb_agent::type_id::create("ahb_agent",this);
    end

    if(env_cfg.has_ppi_agent)
    begin
       
      uvm_config_db #(ppi_agent_config)::set(this,"*","ppi_agent_config",env_cfg.ppi_cfg);
      ppi_agenth =ppi_agent::type_id::create("ppi_agent",this);
    end

    if(env_cfg.has_dc_agent)
    begin
      
      uvm_config_db #(dc_agent_config)::set(this,"*","dc_agent_config",env_cfg.dc_cfg);
      dc_agenth =dc_agent::type_id::create("dc_agent",this);
    end

    if(env_cfg.has_dc_agent && env_cfg.has_ppi_agent)
      scoreboard = dsi_scoreboard::type_id::create("scoreboard", this);

    //ahb_cov=mipi_ahb_cov::type_id::create("ahb_cov",this);
    //dc_cov=mipi_dc_cov::type_id::create("dc_cov",this);
    //ppi_cov=mipi_ppi_cov::type_id::create("ppi_cov",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (scoreboard != null) begin
      dc_agenth.monh.dc_port.connect(scoreboard.dc_h.analysis_export);
      ppi_agenth.monh.ppi_port.connect(scoreboard.ppi_h.analysis_export);
    end
endfunction



endclass
