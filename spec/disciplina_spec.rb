require 'spec_helper'
require_relative '../lib/dominio/disciplina'
require_relative '../lib/dominio/curso'


RSpec.describe Disciplina do
  let(:codigo) { "0000000000000" }
  let(:curso) { Curso.new(codigo) }
  let(:disciplina) { Disciplina.new("5145181863", "fisica", 30, curso) }

  it 'valor de codigo correto' do
    expect(disciplina.codigo).to eq("5145181863")
  end
  it 'valor de nome correto' do
    expect(disciplina.nome).to eq("fisica")
  end
  it 'valor de carga correto' do
    expect(disciplina.carga).to eq(30)
  end
  it 'valor de curso correto' do

    expect(disciplina.curso).to eq(curso)
  end
  it 'lança erro se a carga for negativa' do
    expect { Disciplina.new("5145181863", "fisica", -1, curso) }.to raise_error("Carga zerada ou negativa")
  end
   it 'lança erro se a carga for zerada' do
    expect { Disciplina.new("5145181863", "fisica", 0, curso) }.to raise_error("Carga zerada ou negativa")
  end
end