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
      # 1. Gerenciar Curso
      codigo_curso = linha["COD_CURSO"]
      @repositorio_cursos[codigo_curso] ||= Curso.new(codigo_curso)
      curso_atual = @repositorio_cursos[codigo_curso]
      
      # 2. Gerenciar Disciplina (Usando o nome carga_horaria conforme alinhamos)
      codigo_disc = linha["COD_DISCIPLINA"]
      valor_carga = linha["CARGA_HORARIA"].to_i 
      @repositorio_disciplinas[codigo_disc] ||= Disciplina.new(codigo_disc, codigo_disc, valor_carga, curso_atual)
      disciplina_atual = @repositorio_disciplinas[codigo_disc]
      
      # 3. Gerenciar Matrícula (Simples, por ID)
      matricula_id = linha["MATRICULA"]
      @repositorio_matriculas[matricula_id] ||= begin
        m = Matricula.new(matricula_id, curso_atual)
        curso_atual.add_matricula(m)
        m
      end
      matricula_atual = @repositorio_matriculas[matricula_id]

      # 4. Criar Nota (Split do período: "2023.1" -> "2023" e "1")
      ano, periodo_semestre = linha["ANO_SEMESTRE"].split('.')
      valor_n = linha["NOTA"].to_f
      
      # Nota.new(valor, disciplina, ano, periodo)
      nova_nota = Nota.new(valor_n, disciplina_atual, ano.to_i, periodo_semestre.to_i)
      
      # 5. Conexões Finais
      matricula_atual.add_notas(nova_nota)
      @notas << nova_nota
      
      # 6. Atualizar CR da Matrícula
      matricula_atual.calcula_cr
      curso_atual.calcula_media_cr
    end
  end

  def matriculas; @repositorio_matriculas.values; end
  def disciplinas; @repositorio_disciplinas.values; end
  def cursos; @repositorio_cursos.values; end
end