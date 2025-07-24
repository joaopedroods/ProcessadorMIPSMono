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
Arquivo:      extensor_sinal.v
Módulo:       extensor_sinal

Descrição:
              Implementa a unidade de extensão de sinal utilizada no caminho de
				  dados de um processador MIPS. Este bloco combinacional recebe um
				  valor imediato de 16 bits (entrada_imm) e realiza a extensão de
				  sinal para 32 bits, preservando a representação correta de valores
				  negativos em complemento de dois. Para isso, replica o bit mais
				  significativo do imediato (bit de sinal) nos 16 bits superiores da
				  saída. O resultado é enviado para saida_ext, sendo utilizado em
				  instruções do tipo I que operam com valores imediatos, como addi, lw e sw.
================================================================================
*/

module extensor_sinal (in, out);

   //entradas e saídas:
   input wire [15:0] in;   //imediato de 16 bits a ser extendido (entrada)
   output wire [31:0] out; //saída com o sinal extendido pra 32 bits
	
   //faz xtensão de sinal replicando o msb do imediado de entrada:
   assign out = {{16{in[15]}}, in};

endmodule