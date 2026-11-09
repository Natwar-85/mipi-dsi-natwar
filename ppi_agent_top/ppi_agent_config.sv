class ppi_agent_config extends uvm_object;
`uvm_object_utils(ppi_agent_config)

function new(string name="ppi_config");
        super.new(name);
endfunction

uvm_active_passive_enum is_active=UVM_PASSIVE;
virtual ppi_if vif;

endclass



