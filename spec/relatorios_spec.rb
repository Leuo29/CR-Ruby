require 'spec_helper'
require_relative '../lib/controlador/relatorio'

RSpec.describe Relatorio do

  let(:curso_1) { double('Curso', codigo: "10", calcula_media_cr: 12.5) }
  let(:curso_2) { double('Curso', codigo: "11", calcula_media_cr: 45.0) }
  
  let(:matricula_1) { double('Matricula', codigo: "100", cr: 10.0) }
  let(:matricula_2) { double('Matricula', codigo: "101", cr: 11.0) }
  let(:matricula_3) { double('Matricula', codigo: "116", cr: 26.0) }


  let(:lista_matriculas) { [matricula_1, matricula_2, matricula_3] }
  let(:lista_cursos) { [curso_1, curso_2] }
  
  subject { Relatorio.new(lista_matriculas, lista_cursos) }

  it 'imprime o relatório formatado com múltiplas linhas' do

  saida_esperada = <<~TEXTO
    ------- O CR dos alunos é: --------
    100  -  10.0
    101  -  11.0
    116  -  26.0
    -----------------------------------
    ----- Média de CR dos cursos ------
    10  -  12.5
    11  -  45.0
    -----------------------------------
  TEXTO

  expect { subject.imprimir }.to output(saida_esperada).to_stdout
end
end