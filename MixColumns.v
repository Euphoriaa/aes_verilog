module MixColumns(input [127:0] in, output [127:0] out);

    genvar i;
    generate
      for(i = 0; i < 16; i = i + 4) begin : column
            wire [7:0] s0;
            wire [7:0] s1;
            wire [7:0] s2;
            wire [7:0] s3;
            
            wire [7:0] s0_;
            wire [7:0] s1_;
            wire [7:0] s2_;
            wire [7:0] s3_;
            
           

            assign s0 = in[i*8+:8];
            assign s1 = in[(i+1)*8+:8];
            assign s2 = in[(i+2)*8+:8];
            assign s3 = in[(i+3)*8+:8];

            assign s0_= (s0 << 1) ^ ((s1 << 1) ^ s1) ^ s2 ^ s3;
            assign s1_= s0 ^ (s1 << 1) ^ ((s2 << 1) ^ s2) ^ s3;
            assign s2_= s0 ^ s1 ^ (s2 << 1) ^ ((s3 << 1) ^ s3);
            assign s3_= ((s0 << 1) ^ s0) ^ s1 ^ s2 ^ (s3 << 1);

            assign out[(i*8)     +: 8]     = s0_;
            assign out[((i+1)*8) +: 8] = s1_;
            assign out[((i+2)*8) +: 8] = s2_;
            assign out[((i+3)*8) +: 8] = s3_;
        end
    endgenerate
endmodule