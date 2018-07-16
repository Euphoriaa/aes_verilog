//David Peled 208576025
//Tal Levy 209005305

module MixColumns #(parameter NB = 8'd128, BYTE = 4'd8)(input [NB-1:0] in, output [NB-1:0] out);

    genvar i;
    generate
      for(i = 0; i < 16; i = i + 4) begin : column
            
            //In
            wire [BYTE-1:0] s0;
            wire [BYTE-1:0] s1;
            wire [BYTE-1:0] s2;
            wire [BYTE-1:0] s3;
            
            wire [BYTE-1:0] s0_shifted;
            wire [BYTE-1:0] s1_shifted;
            wire [BYTE-1:0] s2_shifted;
            wire [BYTE-1:0] s3_shifted;

            //Out
            wire [BYTE-1:0] s0_;
            wire [BYTE-1:0] s1_;
            wire [BYTE-1:0] s2_;
            wire [BYTE-1:0] s3_;
           
            assign s0 = in[i*8+:8];
            assign s1 = in[(i+1)*8+:8];
            assign s2 = in[(i+2)*8+:8];
            assign s3 = in[(i+3)*8+:8];

            assign s0_shifted = s0[7] ? ((s0 << 1) ^ 8'h1B) : (s0 << 1);
            assign s1_shifted = s1[7] ? ((s1 << 1) ^ 8'h1B) : (s1 << 1);
            assign s2_shifted = s2[7] ? ((s2 << 1) ^ 8'h1B) : (s2 << 1);
            assign s3_shifted = s3[7] ? ((s3 << 1) ^ 8'h1B) : (s3 << 1);

            assign s0_= (s0_shifted) ^ ((s1_shifted) ^ s1) ^ s2 ^ s3;
            assign s1_= s0 ^ (s1_shifted) ^ ((s2_shifted) ^ s2) ^ s3;
            assign s2_= s0 ^ s1 ^ (s2_shifted) ^ ((s3_shifted) ^ s3);
            assign s3_= ((s0_shifted) ^ s0) ^ s1 ^ s2 ^ (s3_shifted);
            
            assign out[(i*8)     +: 8] = s0_;
            assign out[((i+1)*8) +: 8] = s1_;
            assign out[((i+2)*8) +: 8] = s2_;
            assign out[((i+3)*8) +: 8] = s3_;
        end
    endgenerate
endmodule