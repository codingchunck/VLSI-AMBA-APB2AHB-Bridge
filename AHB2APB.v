module main(
    input  clk,      // one clock for both the protocols - from test_bench
    input  preset_n, // from test_bench
    input  apb_addr_test, // from test_bench
  );
// Signal Declaration - SLAVE APB INTERFACE wrt Bridge
reg preset_i;
reg psel_o;
reg penable_o;
reg pwrite_o;
reg [31:0] paddr_o;
reg [31:0] pwdata_o;
reg [31:0] prdata_i;
reg pready_i;
/************************************ AHB ***********************************/



/************************************ APB ***********************************/
  typedef enum logic [1:0]{ST_IDLE,ST_SETUP,ST_ACCESS} apb_state_t;
  apb_state_t curr_q;
  apb_state_t nxt_state;

  always@(posedge clk, negedge )
    if(~preset_n)
      nxt_state = ST_IDLE;
    else
      nxt_state = curr_q;

  always@(*)
  begin
    case(curr_q)
      ST_IDLE: if(psel_o==1'b1 && penable_o==1'b1)
      ST_IDLE;
      else
      nxt_state = ST_SETUP;
      ST_SETUP: nxt_state = ST_ACCESS;
      ST_ACCESS: if(pready_i==1'b1)
      nxt_state = ST_ACCESS;
      else
      nxt_state = ST_IDLE;
      default: nxt_state = ST_IDLE;
      endcase
  end

  assign psel_o = (curr_state == ST_SETUP) | (curr_state == ST_ACCESS);
  assign penable_o = (curr_state == ST_ACCESS);

  // APB Address
  assign paddr_o = {32{curr_state == ST_ACCESS}} & 32'hA000;

always@(posedge clk, negedge preset_n)
if(~preset_n)
pwrite_o = 1'b0;
else
pwrite_o = pwrite_q;

assign pwdata_o = {32{curr_state == ST_ACCESS}} & (prdata_q);


/************************************ Bridge ***********************************/




