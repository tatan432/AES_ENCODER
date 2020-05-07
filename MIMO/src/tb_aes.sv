module tb_aes();
parameter no_of_AES =100;
parameter N =10;
bit clk;
bit start;
bit rstn;
bit [128*N-1:0] plain_text;
bit [128*N-1:0] cipher_key;
bit done;
bit [9:0] completed_round;
bit [128*N-1:0] cipher_text;
bit [127:0] plain_text_mem [no_of_AES*N];
bit [127:0] cipher_key_mem [no_of_AES*N];
bit [127:0] cipher_text_mem [no_of_AES*N];
bit [127:0] cipher_text_ref_mem [no_of_AES*N];
bit [127:0]in_q[N][$];
bit [127:0]in_q_key[N][$];
bit [127:0]out_q[N][$];

AES_top#(N) dut(.*);
int count;
int no_of_errors;
always begin
  #5 clk = ~clk;
end

initial 
begin
    $readmemh("../../ref/plain_text.txt",plain_text_mem);
    $readmemh("../../ref/cipher_key.txt",cipher_key_mem);
    $readmemh("../../ref/cipher_text.txt",cipher_text_ref_mem);
    $vcdplusfile("results.vpd");
    $vcdpluson(0, tb_aes);
    $vcdplusmemon(0,tb_aes);

    for (int i = 0 ; i<no_of_AES;i++)
    begin
        for(int j =0; j<N;j++)
        begin
            in_q[j].push_back(plain_text_mem[i*N+j]);
            in_q_key[j].push_back(cipher_key_mem[i*N+j]);
        end
    end
    clk <= 1'b0;
    rstn <= 1'b0;
    start <= 1'b0;
    rstn <= #22 1'b1;
    start <= #32 1'b1;
end

genvar i;
generate
for (i = 0; i<N; i++)
begin
    always@(in_q[i][0] or in_q_key[i][0])
    begin
        plain_text[128*i+127 : 128*i] =in_q[i][0]; 
        cipher_key[128*i+127 : 128*i] =in_q_key[i][0];
    end
end
endgenerate


always@(negedge clk)
begin
  if (done) 
  begin
    count <= count+1;
    for (int i=0;i<N;i++)
    begin
      in_q_key[i].pop_front();
      in_q[i].pop_front();
      out_q[i].push_back(cipher_text[128*i +: 128]);
    end
  end
  if (count == no_of_AES)
  begin
    for (int i = 0 ; i<no_of_AES;i++)
    begin
        for(int j =0; j<N;j++)
        begin
            cipher_text_mem[i*N+j] = out_q[j][i];
        end
    end
    for (int i = N ; i< no_of_AES*N; i++)
    begin
 
        if (cipher_text_mem[i] != cipher_text_ref_mem[i])
            no_of_errors =no_of_errors+1;
    end
    if (no_of_errors == 0)
    begin
        $display("Congratulations, your code passed all the tests for MIMO...");
    end
    else
    begin
        $display("%d out of %d test cases failed",no_of_errors,no_of_AES*N);
    end
    $finish();
  end
end
endmodule
