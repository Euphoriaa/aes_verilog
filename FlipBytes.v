//David Peled 208576025
//Tal Levy 209005305

//What is this?
//Well, we accidentaly misinterpeted the matricies, and where there should have been the most significant BYTE,
//we interpeted it as the least significant BYTE,
//To simply correct it, we just flip the input bytes
//And output bytes.
module FlipBytes #(parameter NB = 8'd128, BYTE = 4'd8) (input [NB-1:0] in, output [NB-1:0] out);
    genvar i;
    generate
    for(i=0; i < NB/BYTE ; i=i+1) begin : byte
        assign out[(BYTE*i)+:BYTE] = in[(NB-1-BYTE*i)-:BYTE];
    end
    endgenerate
endmodule