// David Peled 208576025
// Tal Levy 209005305
module AddRoundKey #(parameter NB = 8'd128) (input [NB-1:0] in, input [NB-1:0] key, output [NB-1:0] out);
    assign out = in ^ key;
endmodule