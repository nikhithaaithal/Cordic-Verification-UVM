class cordic_scb extends uvm_scoreboard;
  `uvm_component_utils(cordic_scb)
  
  uvm_tlm_analysis_fifo #(cordic_seq_item)inp_mon_fifo;
  uvm_tlm_analysis_fifo #(cordic_seq_item)out_mon_fifo;
  
  cordic_seq_item inp;
  cordic_seq_item out;
  cordic_seq_item expected;

  shortint signed expected_sin;
  shortint signed expected_cos;
  shortint signed expected_product;
 
  shortint signed actual_sin;
  shortint signed actual_cos;
  shortint signed actual_product;
   bit [7:0] actual_bytes[4];
 
  int sin_diff;
  int cos_diff;
 
  real angle_rad;
  real angle_deg;
  real sin_value;
  real cos_value;
  
  int pass=0;
  int fail=0;
  bit rst_seen;
  
  function new( string name="cordic_scb",uvm_component parent);
    super.new(name,parent);
    inp_mon_fifo=new("inp_mon_fifo",this);
    out_mon_fifo= new("out_mon_fifo",this);
    expected=cordic_seq_item::type_id::create("expected");
  endfunction
  
  task sample();
    inp_mon_fifo.get(inp);
    out_mon_fifo.get(out);
    if(!out.rstn)
      rst_seen=1;
  endtask
  /*
   function void reset();
    if ((out.done != 0) || (out.error != 0) || (out.data_out != 0)) begin
      `uvm_error(get_type_name(),
        $sformatf("RESET MISMATCH: done=%0b error=%0b data_out=0x%02h (all expected 0)",
                   out.done, out.error, out.data_out))
      fail++;
    end
    else
      `uvm_info(get_type_name(), "RESET OUTPUTS OK: busy/done/error/data_out all 0", UVM_MEDIUM)
  endfunction
  */
   task reset();
     sample(); 
    if ((out.busy != 0) || (out.done != 0) || (out.error != 0) || (out.data_out != 0)) begin
      `uvm_error(get_type_name(),
        $sformatf("RESET MISMATCH: busy=%0b done=%0b error=%0b data_out=0x%02h (all expected 0)",
                  out.busy, out.done, out.error, out.data_out))
      fail++;
    end
    else
      `uvm_info(get_type_name(), "RESET OUTPUTS OK: busy/done/error/data_out all 0", UVM_MEDIUM)
   endtask
  
  
  task main_process();
     forever 
    begin
      sample();if (rst_seen) return;
      
       if(inp.start && !out.busy) begin
        expected.ang_mul=inp.ang_mul;//c0
         
          sample();if (rst_seen) return;
         expected.inp[7:0]=inp.data_in;//c1
          
          sample();if (rst_seen) return;
         expected.inp[15:8]=inp.data_in;//c2
         
         predict(expected);
          
         do begin
            sample();if (rst_seen) return;
         end
         while(out.done!==1);
         actual_bytes[0] = out.data_out;
         
         if(expected.ang_mul)begin
           for(int i=1;i<4;i++)
             begin
                sample();if (rst_seen) return;
               actual_bytes[i]=out.data_out;
             end
         end
         else begin
           for(int i=1;i<2;i++)
             begin
                sample();if (rst_seen) return;
               actual_bytes[i]=out.data_out;
             end
         end
       compare(out);
    end
    end
  endtask
     
      

 
task run_phase(uvm_phase phase);
  forever begin
    main_process();
    if (rst_seen) begin
      reset();
      rst_seen = 0;
    end
  end
endtask
  
task predict(cordic_seq_item t);

  if (t.ang_mul == 1'b1) begin
    angle_deg    = (real'(t.inp) * 360.0) / 65536.0;
    angle_rad    = angle_deg * 3.141592653589793 / 180.0;
    sin_value    = $sin(angle_rad);
    cos_value    = $cos(angle_rad);
    expected_sin = $rtoi(sin_value * 16384.0);
    expected_cos = $rtoi(cos_value * 16384.0);
    `uvm_info(get_type_name(),
              $sformatf("Expected SIN = %0d COS = %0d for ANGLE=%0d degree inp=%0d", expected_sin, expected_cos,angle_deg,t.inp),
      UVM_MEDIUM)
  end
  else begin
    expected_product = $signed(t.inp[7:0]) * $signed(t.inp[15:8]);
    `uvm_info(get_type_name(),
      $sformatf("Expected PRODUCT = %0d", expected_product),
      UVM_MEDIUM)
  end
endtask
  
function void compare(cordic_seq_item o);

  if (expected.ang_mul == 1'b1) begin
    actual_cos = $signed({actual_bytes[1], actual_bytes[0]});
    actual_sin = $signed({actual_bytes[3], actual_bytes[2]});

    sin_diff = actual_sin - expected_sin;
    cos_diff = actual_cos - expected_cos;
    if (sin_diff < 0) sin_diff = -sin_diff;
    if (cos_diff < 0) cos_diff = -cos_diff;

    if (sin_diff <= 11 && cos_diff <= 11) begin
      `uvm_info(get_type_name(),
        $sformatf("ANGLE MATCHED: SIN=%0d COS=%0d (diff sin=%0d cos=%0d)",
                  actual_sin, actual_cos, sin_diff, cos_diff),
        UVM_LOW)
        pass++;
    end
    else begin
      `uvm_error(get_type_name(),
        $sformatf("ANGLE MISMATCH: exp SIN=%0d COS=%0d, act SIN=%0d COS=%0d (diff sin=%0d cos=%0d)",
                  expected_sin, expected_cos, actual_sin, actual_cos, sin_diff, cos_diff))
      fail++;
    end
  end
  else begin
    actual_product = $signed({actual_bytes[1], actual_bytes[0]});

    if (actual_product == expected_product) begin
      `uvm_info(get_type_name(),
        $sformatf("PRODUCT MATCHED: %0d", actual_product),
        UVM_LOW)
      pass++;
    end
    else begin
      `uvm_error(get_type_name(),
        $sformatf("PRODUCT MISMATCH: Expected=%0d Actual=%0d",
                  expected_product, actual_product))
      fail++;
    end
  end

  if (o.enable == 8'b00111000)
    `uvm_info(get_type_name(), "ENABLE MATCHED", UVM_LOW)
  else
    `uvm_error(get_type_name(),
      $sformatf("ENABLE MISMATCH: exp=%b act=%b", 8'b00111000, o.enable))

endfunction
    
    
    function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),
      $sformatf("SCOREBOARD SUMMARY: PASSED = %0d FAILED = %0d TOTAL = %0d",
                pass, fail, pass+fail),
      UVM_NONE)
  endfunction
 
endclass



        

//////////////////////////////////////////////////////////////////

// class cordic_scb extends uvm_scoreboard;
 
//   `uvm_component_utils(cordic_scb)
 
//   uvm_tlm_analysis_fifo #(cordic_seq_item) inp_mon_fifo;
//   uvm_tlm_analysis_fifo #(cordic_seq_item) out_mon_fifo;
 
//   cordic_seq_item inp;
//   cordic_seq_item out;
 
 
//   bit [7:0] data_l, data_h;
//   bit [15:0] inp_value;
//   bit mode;
// bit busy_status;
//    bit signed [15:0] expected_sin;
//   bit signed [15:0] expected_cos;
//   bit signed [15:0] expected_mul;
 
//   bit [7:0] out_byte[4];
//   bit signed [15:0] actual_sin;
//   bit signed [15:0] actual_cos;
//   bit signed [15:0] actual_mul;
 
//   int a, i;
//   int signed diff_sin, diff_cos;
 
//   real angle_deg, angle_rad;
//   real sin_value, cos_value;
//   int pass=0;
//   int fail=0;
 
 
//   function new(string name="cordic_scb",
//                uvm_component parent=null);
 
//     super.new(name,parent);
 
//     inp_mon_fifo = new("inp_mon_fifo",this);
//     out_mon_fifo = new("out_mon_fifo",this);
 
//   endfunction
 
 
//   task run_phase(uvm_phase phase);
 
//     fork
//       input_process();
//       output_process();
//     join
 
//   endtask
 
 
//   task input_process();
 
//     forever begin
 
//       inp_mon_fifo.get(inp);
 
//       if(inp.start == 1'b1&&out.busy!==1)
//         predict(inp);
 
//     end
 
//   endtask
 
 
//   task predict(cordic_seq_item tr);
 
//     mode = tr.ang_mul;
 
 
//     inp_mon_fifo.get(tr);
//     data_l = tr.data_in;
 
  
//     inp_mon_fifo.get(tr);
//     data_h = tr.data_in;
 
 
//     inp_value = {data_h,data_l};
 
//     if(mode == 1'b1) begin
 
//       angle_deg = (real'(inp_value) * 360.0) / 65536.0;
//       angle_rad = angle_deg * 3.141592653589793 / 180.0;
 
//       sin_value = $sin(angle_rad);
//       cos_value = $cos(angle_rad);
 
//       expected_sin = $rtoi(sin_value * 16384.0);
//       expected_cos = $rtoi(cos_value * 16384.0);
 
//       `uvm_info("SCB",
//         $sformatf("ANGLE=%0d SIN=%0d COS=%0d",
//         inp_value,expected_sin,expected_cos),
//         UVM_MEDIUM)
 
//       repeat(22)
//         inp_mon_fifo.get(tr);
 
//     end
 
//     else begin
 
 
//       expected_mul =
//         $signed(inp_value[7:0]) *
//         $signed(inp_value[15:8]);
 
//       `uvm_info("SCB",
//         $sformatf("A=%0d B=%0d PRODUCT=%0d",
//         $signed(inp_value[7:0]),
//         $signed(inp_value[15:8]),
//         expected_mul),
//         UVM_MEDIUM)
 
     
 
 
//       repeat(20)
//         inp_mon_fifo.get(tr);
 
//     end
 
//   endtask
 
 
// task output_process();
 
//   forever begin
 
   
//     do begin
//       out_mon_fifo.get(out);
// busy_status = out.busy;
//     end while(out.done == 1'b0);
 
 
//     if(mode == 1'b1) begin
 
   
 
//       a = 4;
//       out_byte[0] = out.data_out;
 
//       for(i=1; i<a; i++) begin
//         out_mon_fifo.get(out);
//         out_byte[i] = out.data_out;
//       end
 
//     end
 
//     else begin
 
   
 
//       a = 2;
//       out_byte[0] = out.data_out;
 
//       for(i=1; i<a; i++) begin
//         out_mon_fifo.get(out);
//         out_byte[i] = out.data_out;
//       end
 
//     end
 
//     compare();
 
//   end
 
// endtask
 
 
//   task compare();
 
//     if(mode == 1'b1) begin
 
      
 
//       actual_cos = $signed({out_byte[1],out_byte[0]});
//       actual_sin = $signed({out_byte[3],out_byte[2]});
 
//       diff_sin = int'(actual_sin) - int'(expected_sin);
//       diff_cos = int'(actual_cos) - int'(expected_cos);
 
//       if(diff_sin > 5 || diff_sin < -5) begin
 
//         `uvm_error("SCB",
//           $sformatf("SIN MISMATCH: Expected=%0d Actual=%0d",
//           expected_sin,actual_sin))
//            fail ++;
 
//       end
 
//       if(diff_cos > 5 || diff_cos < -5) begin
 
//         `uvm_error("SCB",
//           $sformatf("COS MISMATCH: Expected=%0d Actual=%0d",
//           expected_cos,actual_cos))
//            fail++;
 
//       end
 
//       if((diff_sin <= 5 && diff_sin >= -5) &&
//          (diff_cos <= 5 && diff_cos >= -5)) begin
 
//         `uvm_info("SCB","ANGLE TEST PASSED",UVM_MEDIUM)
//           pass++;
 
//       end
 
//     end
 
//     else begin
 
   
//       actual_mul = $signed({out_byte[1],out_byte[0]});
 
//       if(actual_mul == expected_mul) begin
 
//         `uvm_info("SCB",
//           $sformatf("MULTIPLICATION PASSED: Expected=%0d Actual=%0d",
//           expected_mul,actual_mul),
//           UVM_MEDIUM)
//          pass++;
 
//       end
 
//       else begin
 
//         `uvm_error("SCB",
//           $sformatf("MULTIPLICATION FAILED: Expected=%0d Actual=%0d",
//           expected_mul,actual_mul))
//         fail++;
          
 
//       end
 
//     end
 
//   endtask
 
// endclass


//       function void report_phase(uvm_phase phase);
//     super.report_phase(phase);
//     `uvm_info(get_type_name(),
//       $sformatf("SCOREBOARD SUMMARY: PASSED = %0d FAILED = %0d TOTAL = %0d",
//                 pass, fail, pass+fail),
//       UVM_NONE)
//   endfunction
        
        
      
          
         

  
