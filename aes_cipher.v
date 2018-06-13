// David Peled 208576025
// Tal Levy 209005305
`include "AddRoundKey.v"
`include "SubBytes.v"
`include "ShiftRows.v"
`include "MixColumns.v"
module aes_cipher (input clk, input rstn, input plain_text, input key, output cipher_text);

    reg [3:0] round;
    reg [127:0] state;
    wire [127:0] nstate;
    ShiftRows sbox(.state(state),.nstate(nstate));

    initial begin
      $dumpfile("aes_cipher.vcp");
      $dumpvars;
      state = 128'h00_11_22_33_44_55_66_77_88_99_AA_BB_CC_DD_EE_FF;
      $finish;
    end

endmodule