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
Arquivo:      adder_PC_4.v
Módulo:       adder_PC_4

Descrição:
              Módulo somador simples que incrementa um valor de 32 bits em 4.
              No contexto do processador MIPS, sua função é calcular o endereço
              da próxima instrução sequencial (PC + 4) a ser buscada pela
              memória de instrução.
================================================================================
*/
module adder_PC_4 (PC_in, PC_out);

// Descrição das portas
	input wire [31:0] PC_in;
	output wire [31:0] PC_out;
	
	assign PC_out = PC_in + 4;
endmodule
