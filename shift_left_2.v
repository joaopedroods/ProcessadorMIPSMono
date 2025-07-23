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
Arquivo:      shift_left_2.v
Módulo:       shift_left_2

Descrição:
              Módulo que realiza um deslocamento lógico de 2 bits para a esquerda
              (shift left 2).
================================================================================
*/

module shift_left_2 (in, out);

// Descrição das portas
	input wire [31:0] in;
	output wire [31:0] out;
	
	assign out = in << 2; 

endmodule
