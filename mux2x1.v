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
Arquivo:      mux2x1.v
Módulo:       mux2x1

Descrição:
              Implementa um multiplexador 2x1 de 32 bits. Este bloco combinacional
				  seleciona, com base no sinal de controle sel, qual dos dois sinais de
				  entrada (in1 ou in2) será encaminhado para a saída result. Quando sel
				  é 0, o valor de in1 é atribuído à saída; caso contrário, in2 é
				  selecionado.
================================================================================
*/

module mux2x1 (in1, in2, sel, result);
    
	//entradas e saídas:
	input wire [31:0] in1;  	   //primeira entrada do mux
   input wire [31:0] in2;  	   //segunda entrada do mux
   input wire sel;               //sel decide qual entrada vai pra saída
   output reg [31:0] result;		//resultado de saida do mux

	//executa sempre que qualquer entrada mudar
	always @(*) begin
        if (sel == 1'b0)			//se o sel for 0, manda in1 pra saída
            result = in1;
        else							//se o sel for 1, envia in2 pra saída
            result = in2;
    end
endmodule