// David Peled 208576025
// Tal Levy 209005305
module AddRoundKey(input [127:0] in, input [127:0] state, output [127:0] out);
    assign out = in ^ state;
endmodule