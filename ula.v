/*
Arquitetura e Organização de Computadores 2025.1 - Projeto da 2ª VA

Integrantes do grupo:
1. Giovanna Neves
2. João Pedro Oliveira da Silva
3. José Albérico
4. Lucas Lins

Conteúdo do arquivo:
*/

module ula(in1, in2, OP, result, zero_flag);

// Descrição das entradas e saídas
	input wire [31:0] in1, in2;
	input wire [3:0] OP;
	output reg [31:0] result;
	output wire zero_flag;
	
// Bloco combinacional: tratamento do opcode para operação
	always @(*) begin
		case(OP)
			4'b0000: result = in1 & in2;	// AND
			4'b0001: result = in1 | in2;	// OR
			4'b0010: result = in1 + in2;	// ADD
			4'b0011: result = in2 << in1[4:0];	// Shift Left Logical Variable - SLLV
			4'b0100: result = in2 >> in1[4:0];	// Shift Right Logical Variable - SRLV
			4'b0101: result = $signed(in1) >>> in2[4:0];	// Shift Right Arithmetic Variable - SRAV
			4'b0110: result = in1 - in2;	// SUB
			4'b0111: result = ($signed(in1) < $signed(in2)) ? 32'b1 : 32'b0; // Signed Less Than - SLT
			4'b1011: result = in1 ^ in2;	// XOR
			4'b1100: result = ~(in1 | in2); // NOR
			4'b1111: result = (in1 < in2) ? 32'b1 : 32'b0; // Set Less Than Unsigned - SLTU
			default: result = 32'b0;
		endcase
	end
	
/*O OP = 1000 represente o BNE, que é somente uma subtração, já tratada pelo OP = 0110.
O BEQ vai usar OP da SUB, então zero_flag = 1 se result = 0. Para o BNE, basta que result != o
para que zero_flag = 1.*/
   assign zero_flag = (result == 32'b0) ? (OP == 4'b1000 ? 1'b0 : 1'b1) : (OP == 4'b1000 ? 1'b1 : 1'b0);
endmodule
