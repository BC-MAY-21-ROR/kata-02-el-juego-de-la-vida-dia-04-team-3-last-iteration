require_relative 'generation'
require_relative 'cell'

class Game
  def initialize
    @cell = Cell.new(0, 0)
    @grid = Generation.new(4, 4, @cell.x)
    create_matriz
  end

  def create_matriz
    # puts 'Primera Generación'
    # Create first generation
    @first_generation = @grid.random_generation(@grid.create_generation)

    pp @first_generation

    @grid.print_universe(@first_generation)

    # puts ' Segunda Genaración'
    # Crear la segunda generación

    @second_generation = @grid.next_generation(@first_generation)
    # puts "\t"
    @grid.print_universe(@second_generation)
  end
end

out = Game.new
