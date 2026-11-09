class ahb_xtn extends uvm_sequence_item;
	//`uvm_object_utils(ahb_xtn)

function new(string name="ahb_xtn");
	super.new(name);
endfunction

rand logic [31:0] haddr;
rand logic [2:0] hsize;
rand logic [31:0] hwdata;
rand logic hwrite;

rand logic [1:0] htrans;
rand logic [2:0] hburst;
rand logic [3:0] hprot;

logic hready;
logic [1:0] hresp;
logic [31:0] hrdata;


`uvm_object_utils_begin(ahb_xtn)
    `uvm_field_int(haddr , UVM_ALL_ON)
    `uvm_field_int(hwdata, UVM_ALL_ON)
    `uvm_field_int(hwrite, UVM_ALL_ON)
    `uvm_field_int(hsize , UVM_ALL_ON)
    `uvm_field_int(hburst, UVM_ALL_ON)
    `uvm_field_int(htrans, UVM_ALL_ON)
    `uvm_field_int(hprot , UVM_ALL_ON)
    `uvm_field_int(hready, UVM_ALL_ON)
    `uvm_field_int(hresp , UVM_ALL_ON)
    `uvm_field_int(hrdata, UVM_ALL_ON)
`uvm_object_utils_end
  
endclass