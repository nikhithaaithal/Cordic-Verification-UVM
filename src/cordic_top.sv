`include "cordic_intf.sv"
`include "cordic.v"
`include "cordic_assertion.sv"
`include "cordic_pkg.sv"

module cordic_top;

  import uvm_pkg::*;
  import cordic_pkg::*;
  bit clk;
  bit rstn;

  always #5 clk = ~clk;

  initial begin
    rstn = 0;
    #1;
    rstn = 1;
    #1;
    rstn = 0;
    repeat(2) @(posedge clk);
    rstn = 1;
    
    
    
    repeat(37) @(posedge clk);
    rstn = 0;
    @(posedge clk);
    rstn = 1;
    
  end

  cordic_intf vif (.clk(clk), .rstn(rstn));

  CORDIC DUT (
    .CLK      (vif.clk),
    .RSTn     (vif.rstn),
    .START    (vif.start),
    .ANG_MUL  (vif.ang_mul),
    .DATA_IN  (vif.data_in),
    .BUSY     (vif.busy),
    .DONE     (vif.done),
    .ERROR    (vif.error),
    .ENABLE   (vif.enable),
    .DATA_OUT (vif.data_out)
  );
  
bind CORDIC cordic_assertion assertion (
  .clk      (CLK),
  .rstn     (RSTn),
  .start    (START),
  .ang_mul  (ANG_MUL),
  .data_in  (DATA_IN),
  .busy     (BUSY),
  .done     (DONE),
  .error    (ERROR),
  .enable   (ENABLE),
  .data_out (DATA_OUT)
);
  
  initial begin
    clk=0;
    uvm_config_db#(virtual cordic_intf)::set( null,"uvm_test_top","cordic_intf",vif);
     $dumpfile("dump.vcd");
     $dumpvars(0, cordic_top);
  end

  initial begin
    run_test( );
  end

endmodule

