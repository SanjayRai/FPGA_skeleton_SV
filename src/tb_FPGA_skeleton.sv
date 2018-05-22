`timescale 1ns/1ns

`include "FPGA_skeleton.vh"

import FPGA_skeleton_PKG::* ;

module tb_FPGA_skeleton;

reg clk = 1'b0;

reg [`AW-1:0] ADDR_IN = 'd0;
reg [(`DW-1):0] DATA_IN = 'd0;
wire [(`ODW-1):0] count;
reg  WR_EN_IN = 1'b0;
reg RD_EN_IN = 1'b0;

reg [31:0]  x_count = 'd0; 

assign count = UUT.i_count;

task wait_N_cyc ;
 input int  NUM_CYC;

 repeat (NUM_CYC) begin
    @(posedge clk);
 end

endtask

task read_results;
    x_count = 'd0;
    repeat ((`DIM_N*`DIM_N)) begin
        @ (posedge clk)
        RD_EN_IN = 1'b1;
        ADDR_IN = x_count;
        x_count++;
    end
    @ (posedge clk);
    RD_EN_IN = 1'b0;
endtask

task create_test_matrix;
    x_count = 'd0; 
    repeat (((`DIM_N*`DIM_N)*2)) begin
        @ (posedge clk);
        ADDR_IN = (x_count);
        DATA_IN = $urandom_range(1,1000); 
        WR_EN_IN = 1'b1;
        x_count++;
    end 
    @ (posedge clk);
    WR_EN_IN = 1'b0;

endtask
always begin
 #CLK_HALF_PRD clk++;
end

initial begin
    $display ("Start of tb_simulation");
    @ (posedge clk);
    create_test_matrix();
    wait_N_cyc(50);
    read_results();
    wait_N_cyc(50);
    create_test_matrix();
    wait_N_cyc(50);
    read_results();
    wait_N_cyc(100);
    $display ("End of tb_simulation");
    $finish;

end

FPGA_skeleton UUT (
.clk_p(clk),
.clk_n(~clk)
);

endmodule
