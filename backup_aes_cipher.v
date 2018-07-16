//David Peled 208576025
//Tal Levy 209005305

`include "AddRoundKey.v"
`include "SubBytes.v"
`include "ShiftRows.v"
`include "MixColumns.v"
`include "KeyExpansion.v"

module aes_cipher(input clk, rstn,
                  input [127:0] plain_text, key,
                  output [127:0] cipher_text);
  wire [127:0] firstAddRoundKeyOUT;
  AddRoundKey addroundkeyStart(.in(plain_text),.key(key),.out(firstAddRoundKeyOUT));
  
  reg start;
  wire [127:0] sboxIN;
  assign sboxIN = start ? firstAddRoundKeyOUT : state;
  
  wire [127:0] sboxOUT;
  SubBytes sbox (.in(sboxIN),.out(sboxOUT));

  wire[127:0] shiftrowsOUT;
  ShiftRows shiftrows(.in(sboxOUT), .out(shiftrowsOUT));
  wire[127:0] mixcolumnsOUT;
  MixColumns mixcolumns(.in(shiftrowsOUT),.out(mixcolumnsOUT));
  wire[127:0] KeyExpansionOUT, addroundkeymiddleOUT;
  
  
  
  reg [127:0] state;
  reg [3:0] round;
  reg [127:0] roundkey;
  
  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      round <= 0;
    end
    else begin
      if(round == 4'd11) begin
        state <= state;
      end
      else begin
      round <= round + 1;
      state <= addroundkeymiddleOUT;
      roundkey <= KeyExpansionOUT;
      end
    end
  end
  
  wire [127:0] keyexpansionIN;
  assign keyexpansionIN = start ? key : roundkey;
  
  KeyExpansion keyexpansion(.RoundKey(keyexpansionIN),.RoundNumber(round),.NextRoundKey(KeyExpansionOUT));

  AddRoundKey addroundkeyMiddle(.in(mixcolumnsOUT),.key(KeyExpansionOUT), .out(addroundkeymiddleOUT));

  always@(*) begin
    if(round == 0) begin
      start = 1'b1;
    end
    else begin
      start = 1'b0;
    end
  end
  
  wire [127:0] sboxOUT2;
  SubBytes sbox2(.in(state),.out(sboxOUT2));
  wire[127:0] shiftrowsOUT2;
  ShiftRows shiftrows2(.in(sboxOUT2),.out(shiftrowsOUT2));
  
  AddRoundKey addroundkeyfinal(.in(shiftrowsOUT2),.key(KeyExpansionOUT),.out(cipher_text));
  
  

endmodule