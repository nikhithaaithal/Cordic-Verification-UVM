class cordic_sequence extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(cordic_sequence)
  
  function new(string name="cordic_sequence");
    super.new(name);
  endfunction
  
  task body();
      `uvm_do_with(req, { inp == 0; ang_mul==1; })   
  endtask

endclass
     
    
class pos_pos_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(pos_pos_seq)
  
  function new(string name="pos_pos_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, { ang_mul==0; inp == 16'h0205; })   
  endtask

endclass

class err_ang_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(err_ang_seq)
  
  function new(string name="err_ang_seq");
    super.new(name);
  endfunction
  
  task body();
    repeat(25) begin
    `uvm_do_with(req, { ang_mul==1; inp == 16'h0205;err ==1; })   
    end
  endtask

endclass

class err_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(err_seq)
  
  function new(string name="err_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==0; inp == 16'h0205;err ==1; })   
  endtask

endclass

class quad1_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(quad1_seq)
  
  function new(string name="quad1_seq");
    super.new(name);l
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==1; inp == 16'h0aab;})//15
    `uvm_do_with(req, {ang_mul==1; inp == 16'h028f;})//3.6
    `uvm_do_with(req, {ang_mul==1; inp == 16'h1555;})//30
    `uvm_do_with(req, {ang_mul==1; inp == 16'h2aab;})//60
    `uvm_do_with(req, {ang_mul==1; inp == 16'h3555;})//75
  endtask

endclass


class quad2_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(quad2_seq)
  
  function new(string name="quad2_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==1; inp == 16'h428f;})//93.6
    `uvm_do_with(req, {ang_mul==1; inp == 16'h4AAB;})//105
    `uvm_do_with(req, {ang_mul==1; inp == 16'h5555;})//120
    `uvm_do_with(req, {ang_mul==1; inp == 16'h6aab;})//150
    `uvm_do_with(req, {ang_mul==1; inp == 16'h7555;})//165
  endtask

endclass

class quad3_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(quad3_seq)
  
  function new(string name="quad3_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==1; inp == 16'h428f;})//93.6
    `uvm_do_with(req, {ang_mul==1; inp == 16'h4AAB;})//105
    `uvm_do_with(req, {ang_mul==1; inp == 16'h5555;})//120
    `uvm_do_with(req, {ang_mul==1; inp == 16'h6aab;})//150
    `uvm_do_with(req, {ang_mul==1; inp == 16'h7555;})//165
  endtask

endclass

class quad4_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(quad4_seq)
  
  function new(string name="quad4_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==1; inp == 16'hcaab;})//285
    `uvm_do_with(req, {ang_mul==1; inp == 16'hd555;})//300
    `uvm_do_with(req, {ang_mul==1; inp == 16'heaab;})//330
    `uvm_do_with(req, {ang_mul==1; inp == 16'hf555;})//345
  endtask

endclass

class repeat_same_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(repeat_same_seq)
  
  function new(string name="repeat_same_seq");
    super.new(name);
  endfunction
  
  task body();
    repeat(25) begin
      `uvm_do_with(req, {inp ==16'hd555; ang_mul==1;}) 
    end
  endtask

endclass

class repeat_diff_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(repeat_diff_seq)
  
  function new(string name="repeat_diff_seq");
    super.new(name);
  endfunction
  
  task body();
    repeat(25) begin
      `uvm_do_with(req, {ang_mul==1;}) 
    end
  endtask

endclass

class neg_neg_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(neg_neg_seq)
  
  function new(string name="neg_neg_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==0; inp == 16'hFFFF; })   
  endtask

endclass

class pos_neg_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(pos_neg_seq)
  
  function new(string name="pos_neg_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==0; inp == 16'hFF03; })   
  endtask

endclass

class neg_pos_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(neg_pos_seq)
  
  function new(string name="neg_pos_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==0; inp == 16'h04FA; })   
  endtask

endclass


class repeat_mul_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(repeat_mul_seq)
  
  function new(string name="repeat_mul_seq");
    super.new(name);
  endfunction
  
  task body();
    repeat(25) begin
    `uvm_do_with(req, {ang_mul==0;})   
    end
  endtask

endclass

class ang_mul_ang_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(ang_mul_ang_seq)
  
  function new(string name="ang_mul_ang_seq");
    super.new(name);
  endfunction
  
  task body();
      `uvm_do_with(req, {ang_mul==1;})  
      `uvm_do_with(req, {ang_mul==0;})
      `uvm_do_with(req, {ang_mul==1;})
  endtask

endclass

class mul_angle_mul_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(mul_angle_mul_seq)
  
  function new(string name="mul_angle_mul_seq");
    super.new(name);
  endfunction
  
  task body();
      `uvm_do_with(req, {ang_mul==0;})
      `uvm_do_with(req, {ang_mul==1;})
      `uvm_do_with(req, {ang_mul==0;})
  endtask

endclass


class angle_sweep_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(angle_sweep_seq)

  function new(string name="angle_sweep_seq");
    super.new(name);
  endfunction

  task body();
    for(int i=0;i<65536;i++) begin
      `uvm_do_with(req, {ang_mul==1; inp==i;})
    end
  endtask
endclass

class mul_sweep_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(mul_sweep_seq)

  function new(string name="mul_sweep_seq");
    super.new(name);
  endfunction

  task body();
    for(int i=-128;i<=127;i++) begin
      for(int j=-128;j<=127;j++) begin
        `uvm_do_with(req, {ang_mul==0; inp=={8'(j),8'(i)};})
      end
    end
  endtask
endclass

class random_angle_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(random_angle_seq)

  function new(string name="random_angle_seq");
    super.new(name);
  endfunction

  task body();
    repeat(25) begin
      `uvm_do_with(req, {ang_mul==1;})
    end
  endtask
endclass


class random_mul_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(random_mul_seq)

  function new(string name="random_mul_seq");
    super.new(name);
  endfunction

  task body();
    repeat(25) begin
      `uvm_do_with(req, {ang_mul==0; err==0;})
    end
  endtask
endclass

class ang_max_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(ang_max_seq)
  
  function new(string name="ang_max_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==1; inp == 16'hFFFF; })   
  endtask

endclass

class angle_270_seq  extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(angle_270_seq )
  
  function new(string name="angle_270_seq ");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==1; inp==16'hC000; })   
  endtask

endclass

class angle_90_seq   extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(angle_90_seq  )
  
  function new(string name="angle_90_seq  ");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, {ang_mul==1;  inp==16'h4000; })   
  endtask

endclass

class angle_180_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(angle_180_seq)

  function new(string name="angle_180_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, {ang_mul==1; inp==16'h8000;})
  endtask
endclass


class zero_a_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(zero_a_seq)

  function new(string name="zero_a_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, { ang_mul==0; inp==16'h1900;})
  endtask
endclass


class zero_b_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(zero_b_seq)

  function new(string name="zero_b_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, { ang_mul==0; inp==16'h0019; })
  endtask
endclass


class max_pos_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(max_pos_seq)

  function new(string name="max_pos_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req,{ang_mul==0; inp==16'h7F7F; })
  endtask
endclass


class min_neg_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(min_neg_seq)

  function new(string name="min_neg_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, { ang_mul==0; inp==16'h8080; })
  endtask
endclass


class max_min_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(max_min_seq)

  function new(string name="max_min_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, {ang_mul==0; inp==16'h807F;})
  endtask
endclass

class boundary_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(boundary_seq)

  function new(string name="boundary_seq");
    super.new(name);
  endfunction

  task body();
    `uvm_do_with(req, { ang_mul==0; inp==16'h7E7E; })
    `uvm_do_with(req, { ang_mul==0; inp==16'h7F7F; })
    `uvm_do_with(req, {start==1; ang_mul==0; inp==16'h8080; })
    `uvm_do_with(req, {start==1; ang_mul==0; inp==16'h8181; err==0;})
    `uvm_do_with(req, {start==1; ang_mul==0; inp==16'h807F; err==0;})
    `uvm_do_with(req, {start==1; ang_mul==0; inp==16'h7F80; err==0;})
    `uvm_do_with(req, {start==1; ang_mul==0; inp==16'h01FF; err==0;})
    `uvm_do_with(req, {start==1; ang_mul==0; inp==16'hFF01; err==0;})
  endtask
endclass

class mode_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(mode_seq)
  
  function new(string name="mode_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, { ang_mul==0; inp == 16'h0309;mode_inject==1; })   
  endtask

endclass

class data_inject_seq extends uvm_sequence#(cordic_seq_item);
  `uvm_object_utils(data_inject_seq)
  
  function new(string name="data_inject_seq");
    super.new(name);
  endfunction
  
  task body();
    `uvm_do_with(req, { ang_mul==1; inp == 16'h4000;start_inject ==1; data_inject==1; })   
  endtask

endclass


