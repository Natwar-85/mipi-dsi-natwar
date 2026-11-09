/*class ppi_seqs extends uvm_sequence #(ppi_xtn);

    function new(string name="ppi_seqs");
        super.new(name);
    endfunction

    task body();
        req=ppi_xtn::type_id::create("ppi_req");
        begin
            start_item(req);
            finish(item);
        end
    endtask

endclass
            */