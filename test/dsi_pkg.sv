package dsi_pkg;

  import uvm_pkg::*;

  `include "uvm_macros.svh"
  `include "dsi_common.sv"

  `include "dc_agent_config.sv"
  `include "ahb_agent_config.sv"
  `include "ppi_agent_config.sv"
  `include "dsi_env_config.sv"
  
  `include "dc_xtn.sv"
  `include "dc_seqr.sv"
  `include "dc_driver.sv"
  `include "dc_monitor.sv"
  `include "dc_agent.sv"
  `include "dc_seqs.sv"

  `include "ahb_xtn.sv"
  `include "ahb_seqr.sv"
  `include "ahb_driver.sv"
  `include "ahb_monitor.sv"
  `include "ahb_agent.sv"
  `include "ahb_seqs.sv"

  `include "ppi_xtn.sv"
  `include "ppi_monitor.sv"
  `include "ppi_agent.sv"

  `include "dsi_scoreboard.sv"

//  `include "mipi_dsi_top_seqr.sv"
 // `include "mipi_dsi_top_seq.sv"
  //`include "scoreboard.sv"
 // `include "ahb_cov.sv"
 // `include "dc_cov.sv"
//  `include "ppi_cov.sv"
  `include "dsi_env.sv"
  `include "dsi_test.sv"
  //`include "ahb_test.sv"
  
endpackage