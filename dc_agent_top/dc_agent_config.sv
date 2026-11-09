class dc_agent_config extends uvm_object;
`uvm_object_utils(dc_agent_config)

function new(string name="dc_agent_config");
        super.new(name);
endfunction

uvm_active_passive_enum is_active=UVM_ACTIVE;
virtual dc_if vif;

endclass



