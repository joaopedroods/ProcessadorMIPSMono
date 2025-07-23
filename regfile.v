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
Arquivo:      regfile.v
Módulo:       regfile

Descrição:
              Implementa o Banco de Registradores (Register File) do MIPS,
              que armazena os 32 registradores de 32 bits. O módulo possui
              duas portas de leitura assíncronas e uma porta de escrita síncrona,
              controlada pelo sinal 'RegWrite'. Garante que o registrador $0
              seja sempre zero e implementa um reset assíncrono para zerar
              todos os dados.
================================================================================
*/

module regfile (ReadAddr1, ReadAddr2, ReadData1, ReadData2, Clock, WriteAddr, WriteData, RegWrite, Reset);
	
// Descrição das entradas e saídas
	input wire Clock, Reset, RegWrite;
	input wire [4:0] ReadAddr1, ReadAddr2, WriteAddr;
	input wire [31:0] WriteData; 
	output wire [31:0] ReadData1, ReadData2;
	
// Banco de Registradores: 32 registradores de 32 bits
   reg [31:0] regs [0:31];
	
// Inteiro para o for que zerará os registradores
	integer i;
	
// Saídas para leitura dos registradores
   assign ReadData1 = (ReadAddr1 == 5'b0) ? 32'b0 : regs[ReadAddr1];
   assign ReadData2 = (ReadAddr2 == 5'b0) ? 32'b0 : regs[ReadAddr2];
	
	always @(posedge Clock or posedge Reset) begin
		if (Reset) begin
			for (i = 0; i < 32; i = i + 1)
				regs[i] = 32'b0;
		end else if (RegWrite) begin
			if (WriteAddr != 5'b0)
				regs[WriteAddr] <= WriteData;
		end
	end	

endmodule
