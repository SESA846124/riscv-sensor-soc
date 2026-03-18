module riscv_fetch (
    input  logic        clk,      // The heartbeat of the chip
    input  logic        rst_n,    // Reset (Active Low)
    output logic [31:0] pc_out    // The "Address" of the instruction
);

    logic [31:0] pc_reg;

    // This block tells the PC to increment by 4 every clock cycle
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_reg <= 32'h0000_0000; // Start at address 0
        end else begin
            pc_reg <= pc_reg + 4;    // Move to next instruction
        end
    end

    assign pc_out = pc_reg;

endmodule
