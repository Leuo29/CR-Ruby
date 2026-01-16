class Relatorio
  def initialize(matriculas, cursos)
    @matriculas = matriculas
    @cursos = cursos
  end

  def imprimir
    puts "------- O CR dos alunos é: --------"
    @matriculas.each { |m| puts "#{m.codigo}  -  #{m.cr.round(2)}" }
    puts "-----------------------------------"
    
    puts "----- Média de CR dos cursos ------"
    @cursos.each { |c| puts "#{c.codigo}  -  #{c.calcula_media_cr.round(2)}" }
    puts "-----------------------------------"
  end
end