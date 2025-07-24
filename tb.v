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
