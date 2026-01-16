require 'spec_helper'
require_relative '../lib/controlador/controller'
require 'stringio'
RSpec.describe ControladorSistema do
  let(:controller) { ControladorSistema.new }
  let(:csv_conteudo) { "MATRICULA,COD_DISCIPLINA,COD_CURSO,NOTA,CARGA_HORARIA,ANO_SEMESTRE\n100,MAT01,4,10.0,60,2023.1" }
  let(:arquivo_fake) { StringIO.new(csv_conteudo) }

  describe '#executar' do
    it 'processa os dados corretamente usando StringIO' do
      
      allow(Leitor).to receive(:new).and_return(double('Leitor', linhas: CSV.parse(csv_conteudo, headers: true).map(&:to_h)))

      expect { controller.executar('qualquer_caminho.csv') }.to output(
        /4  -  10.0/
      ).to_stdout
    end
  end
end