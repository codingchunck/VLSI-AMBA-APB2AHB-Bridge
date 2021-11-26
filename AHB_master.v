//This is AHB master
module AHB();
input HRESETn_i;
input HCLK_i;
input HREADY_i;
input HRESP_i;
input [31:0] HRDATA_i;
output reg HWRITE_o;
output reg [2:0] HSIZE_o;
output reg [31:0] HADDR_o;
output reg [2:0] HBURST_o;
output reg [3:0] HPROT_o;
output reg [1:0] HTRANS_o;
output reg HMASTLOCK_o;
output reg [31:0] HWDATA_o;

// http://eece.cu.edu.eg/~akhattab/files/courses/ca/AHB_Signals.pdf 
// https://people.engr.tamu.edu/rgutier/web_courses/ceg411_f01/l16.pdf

// Multiplexor


// Slave Address 
/*
Slave1 => 00000000 - 000003FF
Slave2 => 00000400 - 000007FF
Slave3 => 00000800 - 00000C00
*/

// AHB Master



endmodule