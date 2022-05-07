module MEM16 (
    input [7:0] A,
    output wire [15:0] instruc
);
    reg [15:0] ram [0:255];

    initial $readmemb("instruc.txt", ram, 0);

    assign instruc = ram[A];
    
endmodule