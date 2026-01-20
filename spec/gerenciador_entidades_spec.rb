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
        "ANO_SEMESTRE" => "20231"
      }
    ]
  end

  let(:gerenciador) { Gerenciador.new(dados_brutos) }

  describe '#processar' do
    before { gerenciador.processar }
    #------------curso_----------------------
    it 'cria instâncias da classe Curso' do
      expect(gerenciador.cursos).to all(be_a(Curso))
    end

    it 'preenche o código e o nome do curso corretamente' do
      curso = gerenciador.cursos.first
      expect(curso.codigo).to eq("ENG_COMP")
      expect(curso.nome).to eq("ENG_COMP") 
    end

    it 'inicia o curso com a matrícula vinculada (se houver nota no CSV)' do
      curso = gerenciador.cursos.first
      
      expect(curso.matriculas.size).to eq(1)
    end

    it 'inicia o curso com a matrícula vinculada (se houver nota no CSV)' do
      curso = gerenciador.cursos.first
      
      expect(curso.calcula_media_cr).to eq(8.5)
    end

    it 'inicia o curso com a matrícula certa' do
      curso = gerenciador.cursos.first
      mat = curso.matriculas.first
      
      expect(mat.codigo).to eq("100")
    end
    
    it 'não cria cursos duplicados para o mesmo código' do
      
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
      expect(disciplina.nome).to eq("MAT01") 
    end

    it 'inicia o disciplina com o curso certo' do
      disciplina = gerenciador.disciplinas.first
      
      expect(disciplina.curso.nome).to eq("ENG_COMP")
    end

    it 'inicia o curso com a carga certa' do
      disciplina = gerenciador.disciplinas.first
      
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
     
      expect(nota.disciplina.nome).to eq("MAT01")
    end
    it 'inicia a nota com o periodo certo' do
      nota = gerenciador.notas.first
      expect("#{nota.ano}.#{nota.periodo}").to eq("2023.1")
    end


    it 'mantém o aluno no primeiro curso encontrado e ignora trocas subsequentes' do
      dados_troca_curso = [

        { "MATRICULA" => "100", "COD_DISCIPLINA" => "A", "COD_CURSO" => "4", "NOTA" => 10.0, "CARGA_HORARIA" => 60, "ANO_SEMESTRE" => "2023.1" },
        
        { "MATRICULA" => "100", "COD_DISCIPLINA" => "B", "COD_CURSO" => "56", "NOTA" => 8.0, "CARGA_HORARIA" => 60, "ANO_SEMESTRE" => "2023.2" },

        { "MATRICULA" => "101", "COD_DISCIPLINA" => "C", "COD_CURSO" => "56", "NOTA" => 6.0, "CARGA_HORARIA" => 60, "ANO_SEMESTRE" => "2023.2" }
      ]
      
      gn = Gerenciador.new(dados_troca_curso)
      gn.processar
      
      curso_4 = gn.cursos.find { |c| c.codigo == "4" }
      curso_56 = gn.cursos.find { |c| c.codigo == "56" }
      aluno_100 = gn.matriculas.find { |m| m.codigo == "100" }
      

      expect(aluno_100.curso.codigo).to eq("4")
      expect(curso_4.matriculas).to include(aluno_100)
      expect(curso_56.matriculas).not_to include(aluno_100)
      

      expect(aluno_100.cr).to eq(9.0)
      

      expect(curso_4.calcula_media_cr).to eq(9.0)
      

      expect(curso_56.calcula_media_cr).to eq(6.0)
    end


  end
end