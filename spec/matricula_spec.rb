require 'spec_helper'
require_relative '../lib/dominio/matricula'

RSpec.describe Matricula do
  let(:matricula) { Matricula.new("2023.1", "Engenharia") }

  it 'calcula o CR ponderado corretamente' do
    # Criando objetos fake para simular as notas e disciplinas
    disc1 = double('Disciplina', carga_horaria: 60)
    nota1 = double('Nota', valor: 80, disciplina: disc1)
    
    disc2 = double('Disciplina', carga_horaria: 30)
    nota2 = double('Nota', valor: 100, disciplina: disc2)
    
    matricula.add_notas(nota1)
    matricula.add_notas(nota2)
    
    # Cálculo: (80*60 + 100*30) / (60+30) = 86.67
    expect(matricula.calcula_cr).to eq(86.67)
  end
end