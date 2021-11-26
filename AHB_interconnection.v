// AHB Interconnect Completed
module AHB_interconnection(
input [31:0] HADDR_i;  // input from master
input HCLK_i;          // input common to all components

// inputs from 16 slaves
input [31:0] HRDATA_i0;
input [31:0] HRDATA_i1;
input [31:0] HRDATA_i2;
input [31:0] HRDATA_i3;
input [31:0] HRDATA_i4;
input [31:0] HRDATA_i5;
input [31:0] HRDATA_i6;
input [31:0] HRDATA_i7;
input [31:0] HRDATA_i8;
input [31:0] HRDATA_i9;
input [31:0] HRDATA_i10;
input [31:0] HRDATA_i11;
input [31:0] HRDATA_i12;
input [31:0] HRDATA_i13;
input [31:0] HRDATA_i14;
input [31:0] HRDATA_i15;

input HRESP_i0;
input HRESP_i1;
input HRESP_i2;
input HRESP_i3;
input HRESP_i4;
input HRESP_i5;
input HRESP_i6;
input HRESP_i7;
input HRESP_i8;
input HRESP_i9;
input HRESP_i10;
input HRESP_i11;
input HRESP_i12;
input HRESP_i13;
input HRESP_i14;
input HRESP_i15;

input HREADY_i0;
input HREADY_i1;
input HREADY_i2;
input HREADY_i3;
input HREADY_i4;
input HREADY_i5;
input HREADY_i6;
input HREADY_i7;
input HREADY_i8;
input HREADY_i9;
input HREADY_i10;
input HREADY_i11;
input HREADY_i12;
input HREADY_i13;
input HREADY_i14;
input HREADY_i15;

output reg HSEL_0;     // select lines to slave
output reg HSEL_1;
output reg HSEL_2;
output reg HSEL_3;
output reg HSEL_4;
output reg HSEL_5;
output reg HSEL_6;
output reg HSEL_7;
output reg HSEL_8;
output reg HSEL_9;
output reg HSEL_10;
output reg HSEL_11;
output reg HSEL_12;
output reg HSEL_13;
output reg HSEL_14;
output reg HSEL_15;

// output from selected slave
output reg [31:0] HRDATA_o;
output reg HRESP_o;          // 0- OKAY , 1-ERROR
output reg HREADY_o;         // 0-transfer not completed, 1-transfer completed
);

reg [3:0] mul_sel;   // mux select lines

//RESET logic
always@(posedge HCLK_i)
if(~HRESETn_i)            // active-low reset signal
begin
HSEL_0=1'b0;     // select lines to slave
HSEL_1=1'b0;
HSEL_2=1'b0;
HSEL_3=1'b0;
HSEL_4=1'b0;
HSEL_5=1'b0;
HSEL_6=1'b0;
HSEL_7=1'b0;
HSEL_8=1'b0;
HSEL_9=1'b0;
HSEL_10=1'b0;
HSEL_11=1'b0;
HSEL_12=1'b0;
HSEL_13=1'b0;
HSEL_14=1'b0;
HSEL_15=1'b0;
HRDATA_o=32'bx;
HRESP_o=1'b0;
HREADY_o=1'b0;
end

always@(posedge HCLK_i)
begin
    // Decoder - uses most significant bits from the address to select a slave.
    // Uses two most significatn bits to decoder the slave.
    case({HADDR_o[31],HADDR_o[30],HADDR_o[29],HADDR_o[28]})
        "0000": begin
                HSEL_0=1'b1;
                mul_sel=4'b0000;
        end
        "0001": begin
            HSEL_1=1'b1;
            mul_sel=4'b0001;
            end
        "0010": begin
            HSEL_2=1'b1;
            mul_sel=4'b0010;
            end
        "0011": begin
            HSEL_3=1'b1;
            mul_sel=4'b0011;
            end
        "0100": begin
            HSEL_4=1'b1;
            mul_sel=4'b0100;
            end
        "0101": begin
                HSEL_5=1'b1;
                mul_sel=4'b0101;
                end
        "0110": begin
            HSEL_6=1'b1;
            mul_sel=4'b0110;
            end
        "0111": begin
            HSEL_7=1'b1;
            mul_sel=4'b0111;
            end
        "1000": begin
            HSEL_8=1'b1;
            mul_sel=4'b1000;
            end
        "1001": begin
            HSEL_9=1'b1;
            mul_sel=4'b1001;
            end
        "1010": begin
            HSEL_10=1'b1;
            mul_sel=4'b1010;
            end
        "1011": begin
            HSEL_11=1'b1;
            mul_sel=4'b1011;
            end
        "1100": begin
            HSEL_12=1'b1;
            mul_sel=4'b1100;
            end
        "1101": begin
            HSEL_13=1'b1;
            mul_sel=4'b1101;
            end
        "1110": begin
            HSEL_14=1'b1;
            mul_sel=4'b1110;
            end
        "1111": begin
            HSEL_15=1'b1;
            mul_sel=4'b1111;
            end
    endcase
    
    // Multiplxor
    case(mul_sel)
    "0000":begin
        HRDATA_o = HRDATA_i0;
        HRESP_o = HRESP_i0;
        HREADY_o = HREADY_i0;
    end
    "0001":begin
        HRDATA_o = HRDATA_i1;
        HRESP_o = HRESP_i1;
        HREADY_o = HREADY_i1;
    end
    "0010":begin
        HRDATA_o = HRDATA_i2;
        HRESP_o = HRESP_i2;
        HREADY_o = HREADY_i2;
    end
    "0011":begin
        HRDATA_o = HRDATA_i3;
        HRESP_o = HRESP_i3;
        HREADY_o = HREADY_i3;
    end
    "0100":begin
        HRDATA_o = HRDATA_i4;
        HRESP_o = HRESP_i4;
        HREADY_o = HREADY_i4;
    end
    "0101":begin
        HRDATA_o = HRDATA_i5;
        HRESP_o = HRESP_i5;
        HREADY_o = HREADY_i5;
    end
    "0110":begin
        HRDATA_o = HRDATA_i6;
        HRESP_o = HRESP_i6;
        HREADY_o = HREADY_i6;
    end
    "0111":begin
        HRDATA_o = HRDATA_i7;
        HRESP_o = HRESP_i7;
        HREADY_o = HREADY_i7;
    end
    "1000":begin
        HRDATA_o = HRDATA_i8;
        HRESP_o = HRESP_i8;
        HREADY_o = HREADY_i8;
    end
    "1001":begin
        HRDATA_o = HRDATA_i9;
        HRESP_o = HRESP_i9;
        HREADY_o = HREADY_i9;
    end
    "1010":begin
        HRDATA_o = HRDATA_i10;
        HRESP_o = HRESP_i10;
        HREADY_o = HREADY_i10;
    end
    "1011":begin
        HRDATA_o = HRDATA_i11;
        HRESP_o = HRESP_i11;
        HREADY_o = HREADY_i11;
    end
    "1100":begin
        HRDATA_o = HRDATA_i12;
        HRESP_o = HRESP_i12;
        HREADY_o = HREADY_i12;
    end
    "1101":begin
        HRDATA_o = HRDATA_i13;
        HRESP_o = HRESP_i13;
        HREADY_o = HREADY_i13;
    end
    "1110":begin
        HRDATA_o = HRDATA_i14;
        HRESP_o = HRESP_i14;
        HREADY_o = HREADY_i14;
    end
    "1111":begin
        HRDATA_o = HRDATA_i15;
        HRESP_o = HRESP_i15;
        HREADY_o = HREADY_i15;
    end
    endcase
end


endmodule