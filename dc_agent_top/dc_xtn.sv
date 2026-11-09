class dc_xtn extends uvm_sequence_item;
	//`uvm_object_utils(dc_xtn)

function new(string name="dc_xtn");
	super.new(name);
endfunction

  rand logic data_valid;
  rand logic  [23:0] pixel_data[];
  rand int hbp;
  rand int hfp;
  rand int vbp;
  rand int vfp;
  rand int hsa;
  rand int vsa;

  constraint pixel_size_c {pixel_data.size() == `payload_cnt;}


  constraint pixel_data_range_c {foreach(pixel_data[i])pixel_data[i] inside {
        [24'h000000 : 24'hFFFFFF]};}
  
  constraint data_valid_c {data_valid == 1'b1;}
  constraint hbp_c {hbp == 4;}
  constraint hfp_c {hfp == 5;}
  constraint vbp_c {vbp == 8;}
  constraint vfp_c {vfp == 12;}
  constraint hsa_c {hsa == 2;}
  constraint vsa_c {vsa == 4;}


`uvm_object_utils_begin(dc_xtn)
    `uvm_field_int(data_valid , UVM_ALL_ON)
    `uvm_field_array_int(pixel_data, UVM_ALL_ON)
    `uvm_field_int(hfp, UVM_ALL_ON)
    `uvm_field_int(hbp , UVM_ALL_ON)
    `uvm_field_int(hsa, UVM_ALL_ON)
    
    `uvm_field_int(vfp, UVM_ALL_ON)
    `uvm_field_int(vbp , UVM_ALL_ON)
    `uvm_field_int(vsa, UVM_ALL_ON)
   
`uvm_object_utils_end
  
endclass