require 'spec_helper'
require 'stringio'
require_relative '../lib/infra/leitor_csv'

RSpec.describe Leitor do
  # Criamos um CSV fake na memória para o teste
  let(:csv_conteudo) { "MATRICULA,COD_DISCIPLINA,COD_CURSO,NOTA,CARGA_HORARIA,ANO_SEMESTRE\n100,MAT01,10,8.5,60,2023.1" }
  let(:arquivo_fake) { StringIO.new(csv_conteudo) }
  let(:leitor) { Leitor.new(arquivo_fake) }

  describe '#processar' do
    let(:primeira_linha) { leitor.linhas.first }

    it 'lê a matrícula corretamente' do
      expect(primeira_linha["MATRICULA"]).to eq("100")
    end

    it 'lê o código da disciplina' do
      expect(primeira_linha["COD_DISCIPLINA"]).to eq("MAT01")
    end

    it 'lê a nota como string (ou converte para float)' do
      expect(primeira_linha["NOTA"]).to eq("8.5")
    end

    it 'lê o ano_semestre corretamente' do
      expect(primeira_linha["ANO_SEMESTRE"]).to eq("2023.1")
    end
  end
end