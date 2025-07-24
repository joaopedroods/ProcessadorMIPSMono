/*
================================================================================
==                      Informações do Projeto                      ==
================================================================================
Disciplina:     Arquitetura e Organização de Computadores (2025.1)
Professor:      Vítor A. Coutinho
Projeto:        Implementação de um Processador MIPS Monociclo (Projeto da 2ª VA)
Grupo:
                - Giovanna Neves
                - João Pedro Oliveira da Silva
                - José Albérico
                - Lucas Lins

================================================================================
==                      Informações do Arquivo                      ==
================================================================================
Arquivo:        adder_PC_jump.v
Módulo:         adder_PC_jump

Descrição:
                Implementa o somador que calcula o endereço de destino para
                instruções de desvio (branch e jump). Este bloco combinacional
                soma o valor do Program Counter (PC) com um deslocamento (offset)
                para gerar o endereço final, seguindo a lógica:
                endereco_jump = endereco_PC + endereco_deslocado.
================================================================================
*/

module adder_PC_jump (endereco_PC, endereco_deslocado, endereco_jump);

	// Descrição das entradas e saídas:
   input wire [31:0] endereco_PC;          // Valor atual do PC
   input wire [31:0] endereco_deslocado; 	 // Endereço deslocado (após o Shift Left 2)
   output wire [31:0] endereco_jump;       // Endereço final do Jump (Saída) 

   // Comportamento:
   assign endereco_jump = endereco_PC + endereco_deslocado;  // soma os endereco do pc e o endereco deslocado e retorna em endereco_jump	
endmodule
