/*
================================================================================
==                        Informações do Projeto                        ==
================================================================================
Disciplina:   Arquitetura e Organização de Computadores (2025.1)
Professor:    Vítor A. Coutinho
Projeto:      Implementação de um Processador MIPS Monociclo (Projeto da 2ª VA)
Grupo:
              - Giovanna Neves
              - João Pedro Oliveira da Silva
              - José Albérico
              - Lucas Lins

================================================================================
==                        Informações do Arquivo                        ==
================================================================================
Arquivo:      control.v
Módulo:       ctrl

Descrição:
              Implementa a Unidade de Controle principal do processador MIPS.
              Este bloco combinacional decodifica o 'opcode' da instrução para
              gerar todos os sinais que governam o caminho de dados, como
              habilitação de escrita, seleção de multiplexadores e a operação
              da ULA. É o componente central que dita o comportamento do
              processador para cada tipo de instrução.
================================================================================
*/

module ctrl (opcode, RegDst, Branch, MemRead, MemToReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, Link);

// Descrição das portas
	input wire [5:0] opcode;
	output reg [3:0] ALUOp;
	output reg RegDst, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, Jump, Link;

	always @(*) begin
		RegDst = 0;
		ALUSrc = 0;
		MemToReg = 0;
		RegWrite = 0;
		MemRead = 0;
		MemWrite = 0;
		Branch = 0;
		Jump = 0;
		Link = 0;
		ALUOp = 4'b0000;
		
		case (opcode)
			
			// lw
			6'b100011: begin
				ALUSrc = 1;
				MemRead = 1;
				MemToReg = 1;
				RegWrite = 1;
			end
				
			// sw
			6'b101011: begin
				ALUSrc = 1;
				MemWrite = 1;
			end
				
			// Instruções R
			6'b000000: begin
				RegDst = 1;
				RegWrite = 1;
				ALUOp = 4'b1111;
			end
				
			// beq
			6'b000100: begin
				Branch = 1;
				ALUOp = 4'b0100;
			end
		
			// bne
			6'b000101: begin
				Branch = 1;
				ALUOp = 4'b0101;
			end
				
			// jump
			6'b000010: begin
				Jump = 1;
			end
				
			// jal
			6'b000011: begin
				RegWrite = 1;
				Link = 1;
				Jump = 1;
			end
				
			// addi
			6'b001000: begin
				ALUSrc = 1;
				RegWrite = 1;
				ALUOp = 4'b1000;
			end
				
			// andi 
			6'b001100: begin
				ALUSrc = 1;
				RegWrite = 1;
				ALUOp = 4'b1100;
			end
			
			// ori
			6'b001101: begin
				ALUSrc = 1;
				RegWrite = 1;
				ALUOp = 4'b1101;
			end
				
			// xori
			6'b001110: begin
				ALUSrc = 1;
				RegWrite = 1;
				ALUOp = 4'b1110;
			end
				
			// slti
			6'b001010: begin
				ALUSrc = 1;
				RegWrite = 1;
				ALUOp = 4'b1010;
			end
				
			// sltiu
			6'b001011: begin
				ALUSrc = 1;
				RegWrite = 1;
				ALUOp = 4'b1011;
			end
				
			// lui
			6'b001111: begin
				ALUSrc = 1;
				RegWrite = 1;
				ALUOp = 4'b1111;
			end
				
			default: begin
					$display("Opcode %b não válido.", opcode);
			end
		
		endcase
			
	end

endmodule
