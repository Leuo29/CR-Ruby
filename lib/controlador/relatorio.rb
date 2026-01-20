class Relatorio
  def initialize(matriculas, cursos)
    @matriculas = matriculas
    @cursos = cursos
  end

  def imprimir(estrategia = CursoCRPorDisciplina.new)
    puts "------- o CR dos alunos e: --------"
    @matriculas.each do |m| 
      puts "#{m.codigo}  -  #{m.cr.round(2)}" 
    end
    puts "-----------------------------------"
    
    puts "----- media de CR dos cursos ------"
    # pra cada curso poe a logica de calculo escolhida
    @cursos.each do |curso|
      curso.strategy = estrategia

      
      media = curso.calcula_media_cr(@matriculas)
      puts "#{curso.codigo}  -  #{media.round(2)}"
    end
    puts "-----------------------------------"
  end
end