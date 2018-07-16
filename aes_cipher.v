//David Peled 208576025
//Tal Levy 209005305

`include "AddRoundKey.v"
`include "SubBytes.v"
`include "ShiftRows.v"
`include "MixColumns.v"
`include "KeyExpansion.v"
`include "FlipBytes.v"
module aes_cipher #(parameter NB = 128, NC = 4, NK = 4, NR = 10, BYTE = 8, WORD = 32) 
                 (input clk, rstn, start, output reg done,
                  input [NB-1:0] plain_text, key,
                  output [NB-1:0] cipher_text);
                                              //state <= addround key out
  //ACTUAL REGISTERS
  reg [NB-1:0] state, roundkey;
  reg [3:0] round;
  //Mux output into addroundkey
  reg [NB-1:0] addroundkeyIN;
  wire [NB-1:0] subbytes_, shiftrows_, mixcolumns_, addroundkey_, keyexpansion_;
  
  SubBytes sbox(.in(state),.out(subbytes_));
  ShiftRows shiftrows(.in(subbytes_),.out(shiftrows_));
  MixColumns mixcolumns(.in(shiftrows_),.out(mixcolumns_));
  AddRoundKey addroundkey(.in(addroundkeyIN),.key(roundkey),.out(addroundkey_));
  KeyExpansion keyexpansion(.RoundNumber(round),.RoundKey(roundkey),.NextRoundKey(keyexpansion_));

  //Mux that goes into addroundkey
  always@(*) begin
    case(round)
      0: addroundkeyIN = state;
      10: addroundkeyIN = shiftrows_;
      default: addroundkeyIN = mixcolumns_; 
    endcase
  end

  //Manage rounds
  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      state <= {NB{1'b0}};
      roundkey <= {NB{1'b0}};
      round <= {4{1'b0}};
      done <= 1;
    end
    else 
      if(!done) begin // continue cipher
        if(round == 10) begin // check done
          done <= 1'b1;
        end
        round <= round + 1;
        state <= addroundkey_;
        roundkey <= keyexpansion_;
      end

      else //no cipher is on going 
        if(start) begin //start new cipher
          done <= 1'b0;
          roundkey <= key_flipped;
          state <= plain_text_flipped;
        end 
        else begin // do nothing
          roundkey <= {NB{1'b0}};
          round <= {4{1'b0}};
          done <= 1;
        end
  end
  
  wire [NB-1:0] plain_text_flipped;
  wire [NB-1:0] key_flipped;

  FlipBytes flipOUT (.in(state),.out(cipher_text));
  FlipBytes flipPLAIN_TEXT (.in(plain_text),.out(plain_text_flipped));
  FlipBytes flipKEY (.in(key),.out(key_flipped));


endmodule