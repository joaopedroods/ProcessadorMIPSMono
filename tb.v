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
Arquivo:      testbench.v
Módulo:       tb

Descrição:
              Arquivo de Testbench para o Processador MIPS Monociclo.
              Este módulo não é sintetizável e serve exclusivamente para simular
              e verificar o funcionamento do projeto completo.

              Ele é responsável por:
              1. Instanciar o processador (a 'Unit Under Test' - UUT).
              2. Gerar o sinal de 'clock' global.
              3. Aplicar um pulso de 'reset' no início da simulação.
              4. Definir o tempo total de simulação.
================================================================================
*/

`timescale 1ns/1ps

module tb;

  // Entradas
  reg clock;
  reg reset_global;

  // Saídas
  wire [31:0] ula_in1;
  wire [31:0] ula_in2;
  wire [31:0] ALU_out;
  wire [31:0] d_mem_out;
  wire [31:0] PC_out;

  // Instanciando o módulo top-level
  ProcessadorMIPSMono uut (
    .clock(clock),
    .reset_global(reset_global),
    .ula_in1(ula_in1),
    .ula_in2(ula_in2),
    .ALU_out(ALU_out),
    .d_mem_out(d_mem_out),
    .PC_out(PC_out)
  );

  // Geração de clock
  initial begin
    clock = 0;
    forever #10 clock = ~clock; // Clock com período de 20ns
  end

  // Teste inicial
  initial begin
    // Inicializa os sinais
    reset_global = 1;
    #25;
    reset_global = 0;

    // Simulação roda por 5000ns
    #5000;

    // Encerra simulação
    $stop;
	 end
endmodule
