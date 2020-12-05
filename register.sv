`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2020 10:48:53 AM
// Design Name: 
// Module Name: register
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register # (parameter SIZE = 1)(
    input clk, clr, set, enable,
    input [SIZE - 1:0] D,
    output logic [SIZE - 1:0] Q
    );
    
    always_ff @ (posedge clk, posedge clr)
    begin
        if (clr & !set) //if clear is true, clear Q value
            Q = 0;
        else if (!clr & set) //sets to one no matter what
            Q = 1;
        else if (enable) //if clear/set is false and enable is true
            Q = D;
        // no else here will retain previous Q value
    end
endmodule
