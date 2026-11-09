class dsi_env_config extends uvm_object;


// UVM Factory Registration Macro
`uvm_object_utils(dsi_env_config)

//------------------------------------------
// Data Members
//------------------------------------------
// Whether env analysis components are used:
//bit has_functional_coverage = 0;
//bit has_scoreboard = 1;
// Whether the various agents are used:
bit has_dc_agent = 1;
bit has_ahb_agent = 1;
bit has_ppi_agent=1;
// Whether the virtual sequencer is used:
// Configuration handles for the sub_components
ahb_agent_config ahb_cfg;
 dc_agent_config dc_cfg;

ppi_agent_config ppi_cfg;
//ahb_reset_agent_config ahb_reset_cfg;
//scoreboard sb;




//------------------------------------------
// Methods
//------------------------------------------
// Standard UVM Methods:
extern function new(string name = "env_config");

endclass
//-----------------  constructor new method  -------------------//

function dsi_env_config::new(string name = "env_config");
  super.new(name);
endfunction


