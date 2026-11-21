class cordic_test extends uvm_component;
  `uvm_component_utils(cordic_test)
  cordic_env env;
  cordic_config cfg;
  
  function new(string name ="cordic_test",uvm_component parent);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg=cordic_config::type_id::create("cfg");
    if(!uvm_config_db #(virtual cordic_intf)::get(this,"","cordic_intf",cfg.vif))
      `uvm_fatal(get_type_name(),"Test failed");
    uvm_config_db #(cordic_config)::set(this,"*","cordic_config",cfg);
    env=cordic_env::type_id::create("env",this);
  endfunction
  
  function void end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
 endfunction
  
endclass
    

class angle_0 extends cordic_test;
 `uvm_component_utils(angle_0)
  cordic_sequence s0;
  function new(string name="angle_0",uvm_component parent=null);
	super.new(name,parent);
 endfunction
 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
 endfunction
 task run_phase(uvm_phase phase);
 phase.raise_objection(this);
   s0=cordic_sequence::type_id::create("s0");
   s0.start(env.agtin.seqr); 
 phase.drop_objection(this);
 endtask 
endclass


class pos_pos_test extends cordic_test;
  `uvm_component_utils(pos_pos_test)
  pos_pos_seq s1;

  function new(string name="pos_pos_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = pos_pos_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


class err_ang extends cordic_test;
  `uvm_component_utils(err_ang)
  err_ang_seq s2;

  function new(string name="err_ang", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s2 = err_ang_seq::type_id::create("s2");
    s2.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


class err_mul extends cordic_test;
  `uvm_component_utils(err_mul)
  err_seq s2;

  function new(string name="err_mul", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s2 = err_seq::type_id::create("s2");
    s2.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


class quad1 extends cordic_test;
  `uvm_component_utils(quad1)
  quad1_seq s2;

  function new(string name="quad1", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s2 = quad1_seq::type_id::create("s2");
    s2.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


class quad2 extends cordic_test;
  `uvm_component_utils(quad2)
  quad2_seq s;

  function new(string name="quad2", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s = quad2_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


class quad3 extends cordic_test;
  `uvm_component_utils(quad3)
  quad3_seq s;

  function new(string name="quad3", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s = quad3_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class quad4 extends cordic_test;
  `uvm_component_utils(quad4)
  quad4_seq s;

  function new(string name="quad4", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s = quad4_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class repeat_same extends cordic_test;
  `uvm_component_utils(repeat_same)
  repeat_same_seq s;

  function new(string name="repeat_same", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s = repeat_same_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class repeat_diff extends cordic_test;
  `uvm_component_utils(repeat_diff)
  repeat_diff_seq s;

  function new(string name="repeat_diff", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s = repeat_diff_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class neg_neg extends cordic_test;
  `uvm_component_utils(neg_neg)
  neg_neg_seq s1;

  function new(string name="neg_neg", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = neg_neg_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class pos_neg extends cordic_test;
  `uvm_component_utils(pos_neg)
  pos_neg_seq s1;

  function new(string name="pos_neg", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = pos_neg_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


class neg_pos extends cordic_test;
  `uvm_component_utils(neg_pos)
  neg_pos_seq s1;

  function new(string name="neg_pos", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = neg_pos_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class repeat_mul extends cordic_test;
  `uvm_component_utils(repeat_mul)
  repeat_mul_seq s1;

  function new(string name="repeat_mul", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = repeat_mul_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class angle_mul_angle extends cordic_test;
  `uvm_component_utils(angle_mul_angle)
  ang_mul_ang_seq s1;

  function new(string name="angle_mul_angle", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = ang_mul_ang_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass

class mul_angle_mul extends cordic_test;
  `uvm_component_utils(mul_angle_mul)
  mul_angle_mul_seq s1;

  function new(string name="mul_angle_mul", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = mul_angle_mul_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
  
endclass


class angle_sweep extends cordic_test;
  `uvm_component_utils(angle_sweep)
  angle_sweep_seq s1;

  function new(string name="angle_sweep", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = angle_sweep_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class mul_sweep extends cordic_test;
  `uvm_component_utils(mul_sweep)
  mul_sweep_seq s1;

  function new(string name="mul_sweep", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = mul_sweep_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class random_angle extends cordic_test;
  `uvm_component_utils(random_angle)
  random_angle_seq s1;

  function new(string name="random_angle", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = random_angle_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class random_mul extends cordic_test;
  `uvm_component_utils(random_mul)
  random_mul_seq s1;

  function new(string name="random_mul", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s1 = random_mul_seq::type_id::create("s1");
    s1.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class angle_max extends cordic_test;
  `uvm_component_utils(angle_max)
  ang_max_seq s;

  function new(string name="angle_max", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=ang_max_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class angle_270 extends cordic_test;
  `uvm_component_utils(angle_270)
  angle_270_seq s;

  function new(string name="angle_270", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=angle_270_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class angle_90 extends cordic_test;
  `uvm_component_utils(angle_90)
  angle_90_seq s;

  function new(string name="angle_90", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=angle_90_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class angle_180 extends cordic_test;
  `uvm_component_utils(angle_180)
  angle_180_seq s;

  function new(string name="angle_180", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=angle_180_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class zero_a extends cordic_test;
  `uvm_component_utils(zero_a)
  zero_a_seq s;

  function new(string name="zero_a", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=zero_a_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class zero_b extends cordic_test;
  `uvm_component_utils(zero_b)
  zero_b_seq s;

  function new(string name="zero_b", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=zero_b_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class max_pos extends cordic_test;
  `uvm_component_utils(max_pos)
  max_pos_seq s;

  function new(string name="max_pos", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=max_pos_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass


class min_neg extends cordic_test;
  `uvm_component_utils(min_neg)
  min_neg_seq s;

  function new(string name="min_neg", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=min_neg_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass

class max_min extends cordic_test;
  `uvm_component_utils(max_min)
  max_min_seq s;

  function new(string name="max_min", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=max_min_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass

class boundary extends cordic_test;
  `uvm_component_utils(boundary)
  boundary_seq s;

  function new(string name="boundary", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=boundary_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass

class mode extends cordic_test;
  `uvm_component_utils(mode)
  mode_seq s;

  function new(string name="mode", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=mode_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass

class data_inject extends cordic_test;
  `uvm_component_utils(data_inject)
  data_inject_seq s;

  function new(string name="data_inject", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    s=data_inject_seq::type_id::create("s");
    s.start(env.agtin.seqr);
    phase.drop_objection(this);
  endtask
endclass

