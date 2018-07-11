module KeyExpansion #(parameter NB = 128, WORD = 32, NK = 4) (input [NB-1:0] RoundKey, input[3:0] RoundNumber, output [NB-1:0] NextRoundKey);
    wire [WORD-1:0] RotWord;
    wire [WORD-1:0] SubWord;
    
    reg [WORD-1:0] Rcon;
    always@(*) begin
      case(RoundNumber + 4'd1)
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
    assign RotWord = {RoundKey[23:0], RoundKey[31:24]}; //Validate that a0 is the msb
    SubBytes #(5'd4) sbox (.in(RotWord), .out(SubWord));

    wire [WORD-1:0] XOR_RCON_SUBWORD;
    assign XOR_RCON_SUBWORD = Rcon ^ SubWord;
    
    //First = MSB
    //Fourth = LSB
    //TODO: make this a for loop
    wire [WORD-1:0] FirstWord;
    assign FirstWord = RoundKey[127:96] ^ XOR_RCON_SUBWORD;

    wire[WORD-1:0] SecondWord;
    assign SecondWord = RoundKey[95:64] ^ FirstWord;
    
    wire[WORD-1:0] ThirdWord;
    assign ThirdWord = RoundKey[63:32] ^ SecondWord;
    
    wire[WORD-1:0] FourthWord;
    assign FourthWord = RoundKey[31:0] ^ ThirdWord;
    
    assign NextRoundKey = {FirstWord, SecondWord, ThirdWord, FourthWord};


endmodule