require_relative '../dominio/nota'
require_relative '../dominio/curso'
require_relative '../dominio/disciplina'
require_relative '../dominio/matricula'

class Gerenciador
  attr_reader :notas

  def initialize(dados_brutos)
    @dados_brutos = dados_brutos
    @repositorio_cursos = {}
    @repositorio_disciplinas = {}
    @repositorio_matriculas = {}
    @notas = []
  end

  def processar
    @dados_brutos.each do |linha|
      
      curso      = buscar_ou_criar_curso(linha["COD_CURSO"])
      disciplina = buscar_ou_criar_disciplina(linha, curso)
      matricula  = buscar_ou_criar_matricula(linha["MATRICULA"], curso)
      
      
      vincular_nota(linha, disciplina, matricula)
      
      
      matricula.calcula_cr
      curso.calcula_media_cr
    end
  end

    
  def matriculas
    @repositorio_matriculas.values
  end

  def disciplinas
    @repositorio_disciplinas.values
  end

  def cursos
    @repositorio_cursos.values
  end

  private

  def buscar_ou_criar_curso(codigo)
    @repositorio_cursos[codigo] ||= Curso.new(codigo)
  end

  def buscar_ou_criar_disciplina(linha, curso)
    codigo = linha["COD_DISCIPLINA"]
    carga  = linha["CARGA_HORARIA"].to_i
    
    @repositorio_disciplinas[codigo] ||= Disciplina.new(codigo, codigo, carga, curso)
  end

  def buscar_ou_criar_matricula(id, curso)
    @repositorio_matriculas[id] ||= begin
      m = Matricula.new(id, curso)
      curso.add_matricula(m)
      m
    end
  end

  def vincular_nota(linha, disciplina, matricula)
    ano, periodo = linha["ANO_SEMESTRE"].split('.')
    valor        = linha["NOTA"].to_f
    
    nova_nota = Nota.new(valor, disciplina, ano.to_i, periodo.to_i)
    
    matricula.add_notas(nova_nota)
    @notas << nova_nota
  end

end