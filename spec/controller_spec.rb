require 'spec_helper'
require_relative '../lib/controlador/controller'

RSpec.describe ControladorSistema do
  let(:controller) { ControladorSistema.new }
  
  it 'processa os dados usando a estratégia 2 (Por Disciplina)' do

    dados_fake = [{ 
      "MATRICULA" => "100", "COD_DISCIPLINA" => "MAT01", 
      "COD_CURSO" => "4", "NOTA" => 10.0, 
      "CARGA_HORARIA" => 60, "ANO_SEMESTRE" => "2023.1" 
    }]
    

    leitor_mock = double('Leitor', linhas: dados_fake)
    allow(Leitor).to receive(:new).and_return(leitor_mock)


    expect { controller.executar('../../data/notas.csv', 2) }.to output(/4  -  10.0/).to_stdout
  end
end