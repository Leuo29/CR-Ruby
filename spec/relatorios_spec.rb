require 'spec_helper'
require_relative '../lib/controlador/relatorio'
require_relative '../lib/dominio/strategies/cr_por_aluno'
require_relative '../lib/dominio/strategies/cr_por_disciplina'
require_relative '../lib/dominio/strategies/cr_aluno_disciplina'

RSpec.describe Relatorio do

  let(:matricula_1) { double('Matricula', codigo: "100", cr: 8.0) }
  let(:matricula_2) { double('Matricula', codigo: "101", cr: 9.0) }
  let(:lista_matriculas) { [matricula_1, matricula_2] }
  
  let(:curso_eng) { double('Curso', codigo: "ENG") }
  let(:lista_cursos) { [curso_eng] }
  
  subject { Relatorio.new(lista_matriculas, lista_cursos) }

  before do

    allow(curso_eng).to receive(:strategy=)
  end

  context 'ao utilizar a Estratégia 1: Por Aluno' do
    let(:estrategia_aluno) { instance_double(CursoCRPorAluno) }

    it 'imprime o relatório com a média baseada nos alunos' do
      expect(curso_eng).to receive(:strategy=).with(estrategia_aluno)
      expect(curso_eng).to receive(:calcula_media_cr).with(lista_matriculas).and_return(8.5)

      expect { subject.imprimir(estrategia_aluno) }.to output(/ENG  -  8.5/).to_stdout
    end
  end

  context 'ao utilizar a Estratégia 2: Por Disciplina' do
    let(:estrategia_disciplina) { instance_double(CursoCRPorDisciplina) }

    it 'imprime o relatório com a média baseada nas disciplinas' do
      expect(curso_eng).to receive(:strategy=).with(estrategia_disciplina)
      expect(curso_eng).to receive(:calcula_media_cr).with(lista_matriculas).and_return(7.2)

      expect { subject.imprimir(estrategia_disciplina) }.to output(/ENG  -  7.2/).to_stdout
    end
  end

  context 'ao utilizar a Estratégia 3: Aluno-Disciplina' do
    let(:estrategia_aluno_disc) { instance_double(CursoCRAlunoDisciplina) }

    it 'imprime o relatório com a média global de quem participou' do
      expect(curso_eng).to receive(:strategy=).with(estrategia_aluno_disc)
      expect(curso_eng).to receive(:calcula_media_cr).with(lista_matriculas).and_return(9.0)

      expect { subject.imprimir(estrategia_aluno_disc) }.to output(/ENG  -  9.0/).to_stdout
    end
  end

  describe 'Formatação do Cabeçalho e Rodapé' do
    it 'exibe as molduras de separação corretamente' do
      allow(curso_eng).to receive(:calcula_media_cr).and_return(0.0)
      
      output = capture_stdout { subject.imprimir(CursoCRPorAluno.new) }
      
      expect(output).to include("------- o CR dos alunos e: --------")
      expect(output).to include("----- media de CR dos cursos ------")
      expect(output).to include("-----------------------------------")
    end
  end
end


def capture_stdout
  old_stdout = $stdout
  $stdout = StringIO.new
  yield
  $stdout.string
ensure
  $stdout = old_stdout
end