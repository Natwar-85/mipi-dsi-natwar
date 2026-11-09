class ahb_seqs extends uvm_sequence #(ahb_xtn);
    `uvm_object_utils(ahb_seqs)

    function new(string name="ahb_seqs");
        super.new(name);
    endfunction

    task body();

        // buffer register 
            `uvm_do_with(req,{req.haddr==32'h4000_0000;
                                req.hwdata==32'h0;
                                req.hwrite==1'b1;
                                req.hsize==3'd2;
                                req.hburst==3'd0;
                                req.htrans==2'd2;
                                req.hprot==4'b0000;})

            // packet control long or short reg and data type RGB888
            `uvm_do_with(req,{req.haddr==32'h4000_0004;
                                req.hwdata==32'h7c;
                                req.hwrite==1'b1;
                                req.hsize==3'd2;
                                req.hburst==3'd0;
                                req.htrans==2'd2;
                                req.hprot==4'b0000;})


            //Word count register 
            `uvm_do_with(req,{req.haddr  == 32'h4000_0008;
                            req.hwdata == 32'h3c;
                            req.hwrite == 1'b1;
                            req.hsize  == 3'd2;
                            req.hburst == 3'd0;
                            req.htrans == 2'd2;
                            req.hprot  == 4'b0000;})

            //control lane register 
            `uvm_do_with(req,{req.haddr  == 32'h4000_000c;
                            req.hwdata == 32'h3;
                            req.hwrite == 1'b1;
                            req.hsize  == 3'd2;
                            req.hburst == 3'd0;
                            req.htrans == 2'd2;
                            req.hprot  == 4'b0000;})
            
            //ctrl Reg address
            `uvm_do_with(req,{req.haddr  ==32'h4000_0010;
                            req.hwdata == 32'h2;
                            req.hwrite == 1'b1;
                            req.hsize  == 3'd2;
                            req.hburst == 3'd0;
                            req.htrans == 2'd2;
                            req.hprot  == 4'b0000;})
                
    endtask

endclass
            