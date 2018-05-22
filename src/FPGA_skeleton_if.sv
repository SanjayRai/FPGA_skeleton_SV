`include "FPGA_skeleton.vh"

import FPGA_skeleton_PKG::* ;

interface FPGA_skeleton_if ;

    modport Master (
       );

    modport Slave (
       );

endinterface
