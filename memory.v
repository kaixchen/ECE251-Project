module MEM16 (
    input [7:0] A,
    output wire [15:0] instruc
);

    reg [7:0] ram [0:255];

    initial $readmemh("test.txt", ram);

    assign instruc = ram[A];
    
endmodule