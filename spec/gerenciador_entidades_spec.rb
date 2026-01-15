require 'spec_helper'
require_relative '../lib/controlador/gerenciador_entidades'
require_relative '../lib/dominio/curso'
require_relative '../lib/dominio/disciplina'
require_relative '../lib/dominio/matricula'
require_relative '../lib/dominio/nota'

RSpec.describe Gerenciador do
  let(:dados_brutos) do
    [
      {
        "MATRICULA" => "100",
        "COD_DISCIPLINA" => "MAT01",
        "COD_CURSO" => "ENG_COMP",
        "NOTA" => 8.5,
        "CARGA_HORARIA" => 60,
        "ANO_SEMESTRE" => "2023.1"
      }
    ]
  end

  let(:gerenciador) { Gerenciador.new(dados_brutos) }

  describe '#processar' do
    before { gerenciador.processar } # Executa o processamento antes de cada teste abaixo
    #------------curso_----------------------
    it 'cria instâncias da classe Curso' do
      expect(gerenciador.cursos).to all(be_a(Curso))
    end

    it 'preenche o código e o nome do curso corretamente' do
      curso = gerenciador.cursos.first
      expect(curso.codigo).to eq("ENG_COMP")
      expect(curso.nome).to eq("ENG_COMP") # No seu initialize, nome = codigo
    end

    it 'inicia o curso com a matrícula vinculada (se houver nota no CSV)' do
      curso = gerenciador.cursos.first
      # Aqui testamos se a integração funcionou: o curso deve ter 1 matrícula
      expect(curso.matriculas.size).to eq(1)
    end

    it 'inicia o curso com a matrícula vinculada (se houver nota no CSV)' do
      curso = gerenciador.cursos.first
      # Aqui testamos se a integração funcionou: o curso deve ter 1 matrícula
      expect(curso.calcula_media_cr).to eq(8.5)
    end

    it 'inicia o curso com a matrícula certa' do
      curso = gerenciador.cursos.first
      mat = curso.matriculas.first
      # Aqui testamos se a integração funcionou: o curso deve ter 1 matrícula
      expect(mat.codigo).to eq("100")
    end
    
    it 'não cria cursos duplicados para o mesmo código' do
      # Simulando duas linhas do mesmo curso
      dados_duplicados = [dados_brutos[0], dados_brutos[0]]
      gerenciador_duplo = Gerenciador.new(dados_duplicados)
      gerenciador_duplo.processar
      
      expect(gerenciador_duplo.cursos.size).to eq(1)
    end


    #------------disciplina----------------------

    it 'cria instâncias da classe Disciplina' do
      expect(gerenciador.disciplinas).to all(be_a(Disciplina))
    end

    it 'preenche o código e o nome da disciplina corretamente' do
      disciplina = gerenciador.disciplinas.first
      expect(disciplina.codigo).to eq("MAT01")
      expect(disciplina.nome).to eq("MAT01") # No seu initialize, nome = codigo
    end

    it 'inicia o disciplina com o curso certo' do
      disciplina = gerenciador.disciplinas.first
      # Aqui testamos se a integração funcionou: o curso deve ter 1 matrícula
      expect(disciplina.curso.nome).to eq("ENG_COMP")
    end

    it 'inicia o curso com a carga certa' do
      disciplina = gerenciador.disciplinas.first
      # Aqui testamos se a integração funcionou: o curso deve ter 1 matrícula
      expect(disciplina.carga_horaria).to eq(60)
    end
    
    
    #------------Matricula----------------------

    it 'cria instâncias da classe Mtricula' do
      expect(gerenciador.matriculas).to all(be_a(Matricula))
    end

    it 'preenche o código da matricula corretamente' do
      matricula = gerenciador.matriculas.first
      expect(matricula.codigo).to eq("100")
    end

    it 'inicia o matricula com o curso certo' do
      matricula = gerenciador.matriculas.first
      # Aqui testamos se a integração funcionou: o curso deve ter 1 matrícula
      expect(matricula.curso.nome).to eq("ENG_COMP")
    end

    it 'inicia a matricula com as notas certa' do
      matricula = gerenciador.matriculas.first
      nota = matricula.notas.first
      expect(nota.valor).to eq(8.5)
    end
    it 'inicia a matricula com o cr certo' do
      matricula = gerenciador.matriculas.first
      expect(matricula.cr).to eq(8.5)
    end

    it 'não duplica matrículas para o mesmo aluno no mesmo período' do
    # Simulando duas disciplinas para a mesma matrícula
    dados_mesmo_aluno = [
      dados_brutos[0], 
      dados_brutos[0].merge("COD_DISCIPLINA" => "MAT02") 
    ]
    gerenciador_rep = Gerenciador.new(dados_mesmo_aluno)
    gerenciador_rep.processar
    
    expect(gerenciador_rep.matriculas.size).to eq(1)
    expect(gerenciador_rep.matriculas.first.notas.size).to eq(2)
    end

       #------------Notas----------------------

    it 'cria instâncias da classe Nota' do
      expect(gerenciador.notas).to all(be_a(Nota))
    end

    it 'preenche o valor da nota corretamente' do
      nota = gerenciador.notas.first
      expect(nota.valor).to eq(8.5)
    end

    it 'inicia o nota com o curso certo' do
      nota = gerenciador.notas.first
      # Aqui testamos se a integração funcionou: o curso deve ter 1 matrícula
      expect(nota.disciplina.nome).to eq("MAT01")
    end
    it 'inicia a nota com o periodo certo' do
      nota = gerenciador.notas.first
      expect("#{nota.ano}.#{nota.periodo}").to eq("2023.1")
    end 


  end
end