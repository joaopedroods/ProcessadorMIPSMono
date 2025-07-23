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
Arquivo:      PC.v
Módulo:       PC

Descrição:
              Este módulo implementa o Contador de Programa (Program Counter - PC)
              do processador MIPS. É um registrador de 32 bits que armazena o
              endereço da instrução a ser buscada na memória de instrução.
              A cada borda de subida do clock, o PC é atualizado com o valor
              presente na sua entrada 'nextPC'.
*/

module PC(clock, nextPC, PC);

// Descrição das entradas e saídas
	input wire clock;
	input wire [31:0] nextPC;
	output reg [31:0] PC;	
	
// Descrição do comportamento
	always @(posedge clock) begin // Atualização do PC na borda de subida do clock
		PC <= nextPC;
	end

endmodule
