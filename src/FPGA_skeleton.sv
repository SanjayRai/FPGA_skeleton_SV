`timescale 1ns/1ns

`include "FPGA_skeleton.vh"

import FPGA_skeleton_PKG::* ;

module FPGA_skeleton (
input wire clk_p,
input wire clk_n
);


wire clk, clk_i;
(*mark_debug = "true" *)logic unsigned [(`ODW-1) :0] i_count = 'd0;


IBUFGDS u_clk_IBUFGDS (.I(clk_p), .IB(clk_n), .O(clk_i));
BUFG u_clk_BUFG (.I(clk_i), .O(clk));

FPGA_skeleton_if MY_FPGA_if ();

always @ (posedge clk) begin
    i_count <= i_count + 1'b1;
end


endmodule

