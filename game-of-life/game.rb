require_relative 'generation'
require_relative 'cell'

class Game
  def initialize
    @grid = Generation.new(4, 4)
    create_matriz
  end

  def create_matriz
    first_generation = @grid.random_generation(@grid.create_generation)
    @grid.print_universe(first_generation)
    puts '----------'
    second_generation = @grid.next_generation(first_generation)
    @grid.print_universe(second_generation)
  end
end

out = Game.new
