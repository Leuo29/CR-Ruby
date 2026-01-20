require 'spec_helper'
require_relative '../lib/dominio/curso'
require_relative '../lib/dominio/matricula'

RSpec.describe Curso do
  let(:codigo) { "4" }
  let(:curso) { Curso.new(codigo) }

  describe '#initialize' do
    it 'inicia com a estratégia padrão Por Aluno' do
      expect(curso.strategy).to be_a(CursoCRPorAluno)
    end
  end

  describe 'Robustez do Cálculo via Strategy' do
    it 'calcula a média do curso corretamente usando a estratégia padrão' do
      matricula1 = Matricula.new("100", curso)
      matricula2 = Matricula.new("101", curso)
      
      # aluno 1: n 80, c 60 -> CR 80
      disc1 = double('Disciplina', carga_horaria: 60, curso: curso)
      matricula1.add_notas(double('Nota', valor: 80, disciplina: disc1, ano: 2023, periodo: 1))
      
      # aluno 2: n 100, c 30 -> CR 100
      disc2 = double('Disciplina', carga_horaria: 30, curso: curso)
      matricula2.add_notas(double('Nota', valor: 100, disciplina: disc2, ano: 2023, periodo: 1))
      
      
      allow(matricula1).to receive(:cr).and_return(80.0)
      allow(matricula2).to receive(:cr).and_return(100.0)
      
      curso.add_matricula(matricula1)
      curso.add_matricula(matricula2)
      
      # Média: (80 + 100) / 2 = 90.00
      expect(curso.calcula_media_cr).to eq(90.00)
    end

    it 'permite trocar para a Estratégia por Disciplina' do
      curso.strategy = CursoCRPorDisciplina.new
      expect(curso.strategy).to be_a(CursoCRPorDisciplina)
    end
  end
end