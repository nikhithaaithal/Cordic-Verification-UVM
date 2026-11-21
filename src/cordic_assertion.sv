
interface cordic_assertion(
  input bit clk,
  input bit rstn,
  input logic start,
  input logic ang_mul,
  input logic [7:0] data_in,
  input logic busy,
  input logic done,
  input logic error,
  input logic [7:0] enable,
  input logic [7:0] data_out
);

  property busy_check;
    @(posedge clk) disable iff(!rstn)
    $rose(start) |=> busy;
  endproperty
  assert property(busy_check)
    $display("Assertion passed: busy_check");
  else
    $error("Assertion failed: busy_check");

  property error_check;
    @(posedge clk) disable iff(!rstn)
    ($rose(start) && busy) |=> error;
  endproperty
  assert property(error_check)
    $display("Assertion passed: error_check");
  else
    $error("Assertion failed: error_check");
    
    property busy_duration_check1;
     @(posedge clk) disable iff(!rstn)
     ($rose(start)&&(!busy)&& ang_mul) |=> busy[*25];
    endproperty
    assert property(busy_duration_check1)
       $display("Assertion passed: busy_duration_check1");
    else
       $error("Assertion failed: busy_duration_check1");
    
    property busy_duration_check2;
      @(posedge clk) disable iff(!rstn)
      ($rose(start) && (!busy) && (!ang_mul)) |=> busy[*23];
    endproperty
    assert property(busy_duration_check2)
       $display("Assertion passed: busy_duration_check2");
    else
       $error("Assertion failed: busy_duration_check2");
       
     property enable_check;
       @(posedge clk) disable iff(!rstn)
       done |-> enable==8'b00111000;
     endproperty
     assert property(enable_check)
       $display("Assertion passed: enable_check");
     else
       $error("Assertion failed: enable_check");
       

       property output_known_check;
       @(posedge clk) disable iff(!rstn)
       !($isunknown(busy)) && !($isunknown(done)) &&!($isunknown(error)) && !($isunknown(data_out));   
     endproperty
     assert property(output_known_check)
     else
       $error("Assertion failed: output_known_check");


     property reset_check;
       @(negedge !rstn)
       !busy && !done && !error && !data_out;
     endproperty
     assert property(reset_check)
      $display("Assertion passed: reset_check");
     else
      $error("Assertion failed: reset_check");

endinterface

