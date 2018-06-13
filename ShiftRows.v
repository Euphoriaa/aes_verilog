
module ShiftRows(input [127:0] state, output [127:0] nstate);
    //NOTE: this assumes that s0_0 is lsb and s[3:3] is msb
    assign nstate = {state[7:0],
                     state[47:40],
                     state[87:80],
                     state[127:120],
                     state[39:32],  
                     state[79:72],  
                     state[119:112],
                     state[31:24],
                     state[71:64],  
                     state[111:104],
                     state[23:16],  
                     state[63:56],
                     state[103:96],
                     state[15:8],  
                     state[55:48], 
                     state[95:88]};

    //after roll
    //assign nstate_0 = {state[7:0], state[39:32], state[71:64], state[103:96]}
    //assign nstate_1 = {state[47:40], state[79:72], state[111,104], state[15:8]}
    //assign nstate_2 = {state[87:80], state[119,112], state[23:16], state[55:48]}
    //assign nstate_3 = {state[127:120], state[31:24], state[63:56], state[95:88]}
endmodule