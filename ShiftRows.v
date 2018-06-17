
module ShiftRows(input [127:0] in, output [127:0] out);
    //NOTE: this assumes that s0_0 is lsb and s[3:3] is msb
    assign out = {in[7:0],
                     in[47:40],
                     in[87:80],
                     in[127:120],
                     in[39:32],  
                     in[79:72],  
                     in[119:112],
                     in[31:24],
                     in[71:64],  
                     in[111:104],
                     in[23:16],  
                     in[63:56],
                     in[103:96],
                     in[15:8],  
                     in[55:48], 
                     in[95:88]};

    //after roll
    //assign nstate_0 = {state[7:0], state[39:32], state[71:64], state[103:96]}
    //assign nstate_1 = {state[47:40], state[79:72], state[111,104], state[15:8]}
    //assign nstate_2 = {state[87:80], state[119,112], state[23:16], state[55:48]}
    //assign nstate_3 = {state[127:120], state[31:24], state[63:56], state[95:88]}
endmodule