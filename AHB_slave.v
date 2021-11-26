module AHB_slave(
input HRESETn_i;
input HCLK_i;
input HSEL;                      // this line is unique for each slave
input [31:0]HADDR_i;
input HWRITE_i;
input [2:0]HSIZE_i;
input [2:0]HBRUST_i;
input [3:0]HPROT_i;
input [1:0]HTRANS_i;
input HMASTLOCK_i;
input HREADY_i;
input HWDATA_i;

output reg HREADYOUT_o;
output reg HRESP_o;
output reg [31:0]HRDATA_o;
);

//RESET logic
always@(posedge HCLK_i)
if(~HRESETn_i)            // active-low reset signal
begin
HRDATA_o=32'bx;
HRESP_o=1'b0;
HREADYOUT_o=1'b0;
end

always@(posedge HCLK_i)
begin
    if
end
