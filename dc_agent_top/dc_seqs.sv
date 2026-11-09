class dc_seqs extends uvm_sequence #(dc_xtn);
`uvm_object_utils(dc_seqs)
    function new(string name="dc_seqs");
        super.new(name);
    endfunction

  task body();

    dc_xtn req;
    int pixel;   

    //8 frames are there
    repeat(`vsync_cnt) begin
    // 5 start of lines will be there 
      repeat(`hsync_cnt) begin
        req = dc_xtn::type_id::create("req");
        start_item(req);

        if (!req.randomize())
          `uvm_fatal("DC_SEQ", "DC transaction randomization failed");
          // eavh line conatains 10 pixels of  each 3 byte long
        for(pixel = 0; pixel < `payload_cnt; pixel++) begin
          req.pixel_data[pixel] = $urandom;
        end

        finish_item(req);
      end
    end
  endtask
endclass
            