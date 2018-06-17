// David Peled 208576025
// Tal Levy 209005305
`include "AddRoundKey.v"
`include "SubBytes.v"
`include "ShiftRows.v"
`include "MixColumns.v"
module aes_cipher (input clk, input rstn, input plain_text, input key, output cipher_text);

  reg [3:0] round;
  reg [127:0] state;
  reg [127:0] key_;

  reg [127:0] addroundkeyINPUT;
  wire [127:0] addroundkeyOUTPUT;
  
  wire [127:0] subbytesINPUT;
  assign subbytesINPUT = state;
  wire [127:0] subbytesOUTPUT;
  
  wire [127:0] shiftrowsINPUT;
  assign shiftrowsINPUT = subbytesOUTPUT;
  wire [127:0] shiftrowsOUTPUT;
  
  wire [127:0] mixcolumnsINPUT;
  assign mixcolumnsINPUT = shiftrowsOUTPUT;
  wire [127:0] mixcolumnsOUTPUT;

  SubBytes subbytes (.in(subbytesINPUT), .out(subbytesOUTPUT));
  ShiftRows shiftrows(.in(shiftrowsINPUT),.out(shiftrowsOUTPUT));
  MixColumns MixColumns(.in(mixcolumnsINPUT),.out(mixcolumnsOUTPUT));
  AddRoundKey addroundkey(.in(addroundkeyINPUT),.state(state),.out(addroundkeyOUT));

  always@(*) begin
    case(round)
      0: addroundkeyINPUT = plain_text;
      10: addroundkeyINPUT = shiftrowsOUTPUT;
      default: addroundkeyINPUT = mixcolumnsOUTPUT;
    endcase   
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      round <= 4'b0;
      state <= 128'b0;
    end
    else begin
      case(round)
        0: begin
          state <= key;
          round <= round + 1;
        end
        10:
        default: begin
          state <= addroundkeyOUT;
          round <= round + 1;
        end
      endcase
    end
  end

endmodule