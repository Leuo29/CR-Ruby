require 'spec_helper'
require_relative '../lib/dominio/curso'
require_relative '../lib/dominio/matricula'
require_relative '../lib/dominio/disciplina'
require_relative '../lib/dominio/nota'

RSpec.describe 'Estratégias de Cálculo de CR' do
  let(:curso) { Curso.new("4") }
  let(:matricula) { Matricula.new("100", curso) }
  let(:disc) { Disciplina.new("D1", "D1", 60, curso) }
  
  before do
    matricula.add_notas(Nota.new(10.0, disc, 2023, 1))
    matricula.calcula_cr # CR = 10.0
    curso.add_matricula(matricula)
  end

  describe CursoCRPorAluno do
    it 'calcula a média baseada no CR individual dos alunos' do
      strategy = CursoCRPorAluno.new
      expect(strategy.calcular(curso, [matricula])).to eq(10.0)
    end
  end

  describe CursoCRPorDisciplina do
    it 'calcula a média ponderada pelas disciplinas do curso' do
      strategy = CursoCRPorDisciplina.new
      expect(strategy.calcular(curso, [matricula])).to eq(10.0)
    end
  end

  describe CursoCRAlunoDisciplina do
    it 'calcula a média global de alunos que participaram do curso' do

      curso_b = Curso.new("21")
      matricula_b = Matricula.new("101", curso_b)
      matricula_b.add_notas(Nota.new(8.0, disc, 2023, 1))
      matricula_b.calcula_cr
      
      strategy = CursoCRAlunoDisciplina.new
      # Deve somar (10.0 + 8.0) / 2
      expect(strategy.calcular(curso, [matricula, matricula_b])).to eq(9.0)
    end
  end
end