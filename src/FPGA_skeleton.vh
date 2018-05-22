`ifndef FPGA_skeleton_SVH
`define FPGA_skeleton_SVH
`default_nettype none 
`define DIM_N 8
`define DW 16 
`define AW $clog2((`DIM_N*`DIM_N*2)+1) 
`define ODW  32 

package FPGA_skeleton_PKG;
    typedef logic [(`DW-1) : 0] IN_MAT_t [(`DIM_N-1):0][(`DIM_N-1):0];
    typedef logic [(`ODW-1) : 0] OUT_MAT_t [(`DIM_N-1):0][(`DIM_N-1):0];

    typedef enum {ACTIVE, COMMAND_DECODE} strm_states;

    typedef enum bit [3:0] {MOVING_AVERAGE = 4'b0001, BYPASS = 4'b0000, CUSTOM_HLS = 4'b0100, SIN_FN = 4'b0010} strm_functions;

    typedef struct {
        logic [31:0] CMD_WORD;
        strm_functions OP_CODE;
        logic [27:0] OP_PARAMS;
    } CMD_HEADER;

    const int CLK_HALF_PRD = 5;
endpackage

`endif /* FPGA_skeleton_SVH */
