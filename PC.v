/*
Arquitetura e Organização de Computadores 2025.1 - Projeto da 2ª VA

Integrantes do grupo:
1. Giovanna Neves
2. João Pedro Oliveira da Silva
3. José Albérico
4. Lucas Lins

Conteúdo do arquivo:

Este arquivo contém o Program Counter (PC), um registrador ... (a terminar)
*/

module PC(clock, nextPC, PC);

	input wire clock;
	input wire [31:0] nextPC;
	output reg [31:0] PC;
	
	always @(posedge clock) begin
		PC <= nextPC;
	end

endmodule
