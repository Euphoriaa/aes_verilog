`timescale 1ns/100ps

`include "aes_cipher.v"

module aes_cipher_tb;
    reg clk, rstn;
    reg [127:0] plain_text, key;
    reg start;
    wire [127:0] cipher_text;
    wire done;
    aes_cipher AES (.clk(clk),.rstn(rstn),.plain_text(plain_text),
                    .key(key),.cipher_text(cipher_text),.start(start),.done(done));
    initial begin
        $dumpfile("aes_cipher_tb.vcp");
        $dumpvars;
        clk = 0;
        rstn = 0;
        start = 1;
        #0.1
        rstn = 1;
        plain_text = 128'h00112233445566778899aabbccddeeff;
        key = 128'h000102030405060708090a0b0c0d0e0f;
        #1 start = 0;
        #30
        $finish;
    end

    always #1 clk = ~clk;

endmodule