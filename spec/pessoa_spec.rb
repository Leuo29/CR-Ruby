require 'spec_helper'
require_relative '../lib/dominio/pessoa'

RSpec.describe Pessoa do

  let(:nome) { "Fulano de Tal" }
  let(:matricula) { 1001 }
  let(:data_nasc) { "2000-01-01" }
  let(:pessoa) { Pessoa.new(nome, matricula, data_nasc) }

  describe '#initialize' do
    it 'armazena o nome corretamente' do
      expect(pessoa.nome).to eq(nome)
    end

    it 'armazena a matrícula corretamente' do
      expect(pessoa.matricula).to eq(matricula)
    end

    it 'inicia com a lista de matriculas vazia' do
      expect(pessoa.matriculas).to be_empty
    end
  end

  describe '#add_matricula' do
    it 'adiciona um item à lista de matriculas' do
      item_matricula = "Objeto Matricula Fake"
      pessoa.add_matricula(item_matricula)
      expect(pessoa.matriculas).to include(item_matricula)
    end
  end
end