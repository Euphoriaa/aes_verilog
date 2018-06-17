module KeyExpansion(input [127:0] RoundKey, input[3:0] RoundNumber, output [127:0] NextRoundKey);
    wire [31:0] RotWord;
    wire [31:0] SubWord;
    
    reg [31:0] Rcon;
    always@(*) begin
      case(RoundNumber)
        4'd1: Rcon = {8'h01,24'h0};
        4'd2: Rcon = {8'h02,24'h0};
        4'd3: Rcon = {8'h04,24'h0};
        4'd4: Rcon = {8'h08,24'h0};
        4'd5: Rcon = {8'h10,24'h0};
        4'd6: Rcon = {8'h20,24'h0};
        4'd7: Rcon = {8'h40,24'h0};
        4'd8: Rcon = {8'h80,24'h0};
        4'd9: Rcon = {8'h1B,24'h0};
        4'd10: Rcon = {8'h36,24'h0};
        default: Rcon = 32'b0;
      endcase
    end
    assign RotWord = {RoundKey[119:96], RoundKey[127:120]};
    SubBytes #(numbytes = 4) sbox (.in(RotWord), .out(SubWord));

    wire [31:0] XOR_RCON_SUBWORD;
    assign XOR_RCON_SUBWORD = Rcon ^ SubWord;
    
    //First = low
    //last = high
    wire [31:0] FirstWord;
    assign FirstWord = RoundKey[31:0] ^ XOR_RCON_SUBWORD;

    wire[31:0] SecondWord;
    assign SecondWord = RoundKey[63:32] ^ FirstWord;
    
    wire[31:0] ThirdWord;
    assign ThirdWord = RoundKey[95:64] ^ SecondWord;
    
    wire[31:0] FourthWord;
    assign FourthWord = RoundKey[127:96] ^ ThirdWord;
    
    assign NextRoundKey = {FourthWord, ThirdWord, SecondWord, FirstWord};


endmodule