require 'spec_helper'
require_relative '../lib/dominio/curso'
require_relative '../lib/dominio/matricula'

RSpec.describe Curso do
 
  
  let(:codigo) { "0000000000000" }
  let(:curso) { Curso.new(codigo) }

  describe '#initialize' do
    it 'armazena o nome corretamente' do
      expect(curso.nome).to eq(codigo)
    end

    it 'armazena o codigo corretamente' do
      expect(curso.codigo).to eq(codigo)
    end

    it 'inicia com a lista de matriculas vazia' do
      expect(curso.matriculas).to be_empty
    end
  end

  describe '#add_matricula' do
    it 'calculo do cr do curso' do
      matricula1 = Matricula.new("2023.1", "Engenharia")
      matricula2 = Matricula.new("2023.2", "Engenharia")
      
      disc1 = double('Disciplina', carga_horaria: 60)
      nota1 = double('Nota', valor: 80, disciplina: disc1)
      
      disc2 = double('Disciplina', carga_horaria: 30)
      nota2 = double('Nota', valor: 100, disciplina: disc2)
      
      matricula1.add_notas(nota1)
      matricula2.add_notas(nota2)
      
      
      matricula1.calcula_cr
      matricula2.calcula_cr

      
      curso.add_matricula(matricula1)
      curso.add_matricula(matricula2)
      # conta: (80*60/60 + 100*30/30) / 2 = 90.00
      expect(curso.calcula_media_cr).to eq(90.00)
    end
  end
end