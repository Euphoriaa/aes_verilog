//David Peled 208576025
//Tal Levy 209005305

module ShiftRows #(parameter NB = 8'd128, BYTE = 4'd8) (input [NB-1:0] in, output [NB-1:0] out);
    
    //Seperated to bytes
    wire [BYTE-1:0] s33;
    wire [BYTE-1:0] s23;
    wire [BYTE-1:0] s13;
    wire [BYTE-1:0] s03;
    
    wire [BYTE-1:0] s32;
    wire [BYTE-1:0] s22;
    wire [BYTE-1:0] s12;
    wire [BYTE-1:0] s02;
    
    wire [BYTE-1:0] s31;
    wire [BYTE-1:0] s21;
    wire [BYTE-1:0] s11;
    wire [BYTE-1:0] s01;

    wire [BYTE-1:0] s30;
    wire [BYTE-1:0] s20;
    wire [BYTE-1:0] s10;
    wire [BYTE-1:0] s00;

    
    assign s33  =  in[127:120];
    assign s23  =  in[119:112];
    assign s13  =  in[111:104];
    assign s03  =  in[103:96];
    
    assign s32  =  in[95:88];
    assign s22  =  in[87:80];
    assign s12  =  in[79:72];
    assign s02  =  in[71:64];
    
    assign s31  =  in[63:56];
    assign s21  =  in[55:48];
    assign s11  =  in[47:40];
    assign s01  =  in[39:32];

    assign s30  =  in[31:24];
    assign s20  =  in[23:16];
    assign s10  =  in[15:8];
    assign s00  =  in[7:0];

    assign out =  {s32, s21, s10, s03,
                   s31, s20, s13, s02,
                   s30, s23, s12, s01,
                   s33, s22, s11, s00};
endmodule


