module tb_aes_sayan();
parameter no_of_AES =1;
bit clk;
bit start;
bit rstn;
bit [127:0] plain_text;
bit [127:0] cipher_key;
bit done;
bit [9:0] completed_round;
bit [127:0] cipher_text;
//bit [127:0] plain_text_mem [no_of_AES];
//bit [127:0] cipher_key_mem [no_of_AES];
//bit [127:0] cipher_text_mem [no_of_AES];
//bit [127:0] initial_round_data_mem [no_of_AES];
//bit [127:0] round1_data_mem [no_of_AES];
//bit [127:0] round2_data_mem [no_of_AES];
//bit [127:0] round3_data_mem [no_of_AES];
//bit [127:0] round4_data_mem [no_of_AES];
//bit [127:0] round5_data_mem [no_of_AES];
//bit [127:0] round6_data_mem [no_of_AES];
//bit [127:0] round7_data_mem [no_of_AES];
//bit [127:0] round8_data_mem [no_of_AES];
//bit [127:0] round9_data_mem [no_of_AES];
//bit [127:0] cipher_text_ref_mem [no_of_AES];
bit [127:0] cipher_text_ref;
bit [31:0] random_number;
bit [127:0] random_number_bigger;

AES_top dut(.*);
int count;
int no_of_errors;
always begin
  #5 clk = ~clk;
end

initial begin
  

    //$dumpfile("results.vcd");
    //$dumpvars(0, PRGRM_CNT_TB);
    //$dumpon;
    $vcdplusfile("results.vpd");
    $vcdpluson(0, tb_aes_sayan);
    $vcdplusmemon(0,tb_aes_sayan);
    clk <= 1'b0;
    rstn <= 1'b0;
    start <= 1'b0;
    #20;
    plain_text=128'h3243F6A8885A308D313198A2E0370734;
    cipher_key=128'h2B7E151628AED2A6ABF7158809CF4F3C;
    cipher_text_ref=128'h3925841D02DC09FBDC118597196A0B32;
    rstn <= #22 1'b1;
    start <= #32 1'b1;

    #10000;
    $vcdplusoff(0, tb_aes_sayan);
    $dumpoff;
    $finish;
end

endmodule
