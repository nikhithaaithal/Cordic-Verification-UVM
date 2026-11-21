class cordic_sub extends uvm_subscriber #(cordic_seq_item);

  `uvm_component_utils(cordic_sub)

  cordic_seq_item in_mon_xn;
   logic signed [7:0] data_in_s;

  covergroup input_cg;

    start_cp: coverpoint in_mon_xn.start {
      bins start_low  = {0};
      bins start_high = {1};
    }

    ang_mul_cp: coverpoint in_mon_xn.ang_mul {
      bins multiplication = {0};
      bins angle          = {1};
    }

    data_in_cp: coverpoint in_mon_xn.data_in {
      bins zero           = {8'h00};
      bins positive       = {[8'h01:8'h7E]};
      bins positive_max   = {8'h7F};
      bins negative_max   = {8'h80};
      bins negative       = {[8'h81:8'hFF]};
    }

    start_ang_mul_cross: cross start_cp, ang_mul_cp {
      bins start_mul = binsof(start_cp) intersect {1} &&
                       binsof(ang_mul_cp) intersect {0};

      bins start_angle = binsof(start_cp) intersect {1} &&
                         binsof(ang_mul_cp) intersect {1};
    }

    ang_mul_data_in_cross: cross ang_mul_cp, data_in_cp;
    
    quadrant: coverpoint in_mon_xn.data_in[7:6] {
       bins quad0 = {2'b00};
       bins quad1 = {2'b01};
       bins quad2 = {2'b10};
       bins quad3 = {2'b11};
    }
    
    angle_corner_cp: coverpoint in_mon_xn.data_in iff (in_mon_xn.ang_mul == 1) {
      bins corner_00 = {8'h00};   // 0x0000
      bins corner_3f = {8'h3F};   // 0x3FFF
      bins corner_40 = {8'h40};   // 0x4000
      bins corner_7f = {8'h7F};   // 0x7FFF
      bins corner_80 = {8'h80};   // 0x8000
      bins corner_bf = {8'hBF};   // 0xBFFF
      bins corner_c0 = {8'hC0};   // 0xC000
      bins corner_ff = {8'hFF};   // 0xFFFF
    }
    
     mul_signed_cp: coverpoint data_in_s iff (in_mon_xn.ang_mul == 0) {
      bins neg_max   = {-128};
      bins neg       = {[-127:-2]};
      bins minus_one = {-1};
      bins zero      = {0};
      bins one       = {1};
      bins pos       = {[2:126]};
      bins pos_max   = {127};
    }

  endgroup

  function new(string name = "cordic_sub", uvm_component parent = null);
    super.new(name, parent);
    input_cg = new();
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  virtual function void write(cordic_seq_item t);
    in_mon_xn = t;
    data_in_s = t.data_in; 
    input_cg.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);

    //`uvm_info(get_name(), $sformatf("INPUT COVERAGE = %0.2f%%", input_cg.get_coverage()), UVM_NONE)
  endfunction

endclass

