require 'spec_helper'
require_relative '../lib/dominio/nota'


RSpec.describe Nota do
  let(:nota) { Nota.new(7.5, "TAC11548", 2020, 2) }

  it 'valor de nota correto' do
    expect(nota.valor).to eq(7.5)
  end
  it 'valor de disciplina correto' do
    expect(nota.disciplina).to eq("TAC11548")
  end
  it 'valor de ano e periodo correto' do
    expect("#{nota.ano}.#{nota.periodo}").to eq("2020.2")
  end

  it 'lança erro se a nota for maior que 10' do
    expect { Nota.new(11, "DISC", 2020, 1) }.to raise_error(StandardError)
  end

  it 'lança erro se a nota for negativa' do
    expect { Nota.new(-1, "DISC", 2020, 1) }.to raise_error("Nota fora do intervalo")
  end
end