module adder_PC_4 (PC_in, PC_out);

// Descrição das portas
	input wire [31:0] PC_in;
	output wire [31:0] PC_out;
	
	assign PC_out = PC_in + 4;
endmodule
