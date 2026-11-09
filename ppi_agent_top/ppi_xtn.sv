class ppi_xtn extends uvm_sequence_item;
	//`uvm_object_utils(ppi_xtn)

function new(string name="ppi_xtn");
	super.new(name);
endfunction

logic [7:0] ppi_data_lane0;
logic [7:0] ppi_data_lane1;
logic [7:0] ppi_data_lane2;
logic [7:0] ppi_data_lane3;

logic ppi_lane0_en;
logic ppi_lane1_en;
logic ppi_lane2_en;
logic ppi_lane3_en;

logic [7:0] payload[$];




`uvm_object_utils_begin(ppi_xtn)
    `uvm_field_int(ppi_data_lane0 , UVM_ALL_ON)
    `uvm_field_int(ppi_data_lane1 , UVM_ALL_ON)
    `uvm_field_int(ppi_data_lane2 , UVM_ALL_ON)
    `uvm_field_int(ppi_data_lane3 , UVM_ALL_ON)

    `uvm_field_int(ppi_lane0_en , UVM_ALL_ON)
    `uvm_field_int(ppi_lane1_en , UVM_ALL_ON)
    `uvm_field_int(ppi_lane2_en , UVM_ALL_ON)
    `uvm_field_int(ppi_lane3_en , UVM_ALL_ON)

   // `uvm_field_int(payload,UVM_ALL_ON)
    
`uvm_object_utils_end
  
endclass