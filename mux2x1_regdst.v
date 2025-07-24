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
Arquivo:      mux2x1_regdst.v
Módulo:       mux2x1_regdst

Descrição:
              Implementa o multiplexador responsável pela seleção do registrador
				  de destino (RegDst) no caminho de dados de um processador MIPS. Este
				  bloco combinacional recebe dois possíveis endereços de registradores
				  (in1 e in2, ambos com 5 bits) e utiliza o sinal de controle sel para
				  definir qual será encaminhado à saída result. Quando sel é 0, o endereço
				  proveniente do campo rt (in1) é selecionado; quando sel é 1, o endereço do
				  campo rd (in2) é escolhido
================================================================================
*/


module mux2x1_regdst (in1, in2, sel, result);
    
	//entradas e saídas:
	input wire [4:0] in1;  	   //primeira entrada do mux
   input wire [4:0] in2;  	   //segunda entrada do mux
   input wire sel;               //sel decide qual entrada vai pra saída
   output reg [4:0] result;		//resultado de saida do mux

	//executa sempre que qualquer entrada mudar
	always @(*) begin
        if (sel == 1'b0)			//se o sel for 0, manda in1 pra saída
            result = in1;
        else							//se o sel for 1, envia in2 pra saída
            result = in2;
    end
endmodule