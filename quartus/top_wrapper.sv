module top_wrapper(
	input clk,
	input enable,
	input nreset,
	output [7:0] led
);

wire [31:0] instr;

top # (
	.ADDR_WIDTH(16)
) u_top (
	 .aclk     (clk),
	 .pclk     ('{clk, clk}),
	 .anreset  (nreset),
	 .pnreset  ('{nreset, nreset}),
	 .aenable  (enable),
	 .penable  ('{enable,enable}),
	 .i_switch (8'h00),
	 .o_instr  (instr)
);

assign led = instr[7:0];

endmodule