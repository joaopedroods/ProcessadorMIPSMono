module shift_left_2 (in, out);

// Descrição das portas
	input wire [31:0] in;
	output wire [31:0] out;
	
	assign out = in << 2; 

endmodule