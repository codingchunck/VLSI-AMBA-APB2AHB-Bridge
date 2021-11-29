module AHB_slave(
    input HRESETn_i;
    input HCLK_i;
    input HSEL;                      // this line is unique for each slave
    input [31:0]HADDR_i;
    input HWRITE_i;                  // 0-Read, 1-Write
    input [2:0]HSIZE_i;              // indicates the size of transfer. 000- 8Byte transfer, 001-16Byte transfer, 010-32Byte transfer...
    // we will use HSIZE_i = 000.
    input [2:0]HBRUST_i;             // indicates the type of burst transfer. 000- single burst. 001- incrementing burst of undefined length. 010- WRAP4...
    input [3:0]HPROT_i;              // protection control signal. Most masters do not generate HPROT signal. Slaves use this signal only when very much needed.
    input [1:0]HTRANS_i;             // indicates the type of transfer. 00- IDLE, 01- BUSY, 10- NONSEQ, 11- SEQ.
    input HMASTLOCK_i;               // indicates to the slave for not allowing any other read-write operationg unless the current transfer completes.
    input HREADY_i;                  // 1- no slave is performting the operation. 0- some slave is occupied by the master/ master is occupied.
    input HWDATA_i;

    output reg HREADYOUT_o;          // indicates that the tranfer has been completed.
    output reg HRESP_o;              // 0- OKAY, 1- ERROR.
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
    if(HSEL && HREADY_i)    // when current slave is selected and no other slave is being occupied by the master.
    begin
      if(~HWRITE_i)
      begin
        HRDATA_o = Mem[HADDR_i];   // Mem is the memory space in slave.
        HREADYOUT_o = 1'b1;
        HRESP_o = 1'b0;
      end
      else
      begin
        Mem[HADDR_i] = HWDATA_i;
        HREADYOUT_o = 1'b0;
        HRESP_o = 1'b0;
      end
    end
    else
    begin
      HRESP_o = 1'b0;
      HRDATA_o=32'bx;
      HREADYOUT_o=1'b0;
    end

  end


endmodule
