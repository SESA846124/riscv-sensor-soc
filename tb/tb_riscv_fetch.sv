`timescale 1ns/1ps

module tb_riscv_fetch;

    // 1. Signals to connect to the module
    logic        clk;
    logic        rst_n;
    logic [31:0] pc_out;

    // 2. Instantiate the module (Connect the wires)
    riscv_fetch dut (
        .clk(clk),
        .rst_n(rst_n),
        .pc_out(pc_out)
    );

    // 3. Generate the Clock (The heartbeat)
    // This creates a 100MHz clock (10ns period)
    always #5 clk = ~clk;

    // 4. The Test Sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;   // Start in Reset

        // Wait 20ns, then release Reset
        #20 rst_n = 1;

        // Let it run for 100ns to see the PC increment
        #100;

        $display("Test Complete. Final PC: %h", pc_out);
        $finish;     // Stop the simulation
    end

    // 5. Waveform Dump (For GTKWave)
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_riscv_fetch);
    end

endmodule