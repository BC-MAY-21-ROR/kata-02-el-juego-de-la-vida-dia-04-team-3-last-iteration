class Game
  attr_accessor :initial_generation

  def initialize(initial_generation = Generation.new(8, 8))
    @initial_generation = initial_generation
  end
end

class Generation
  attr_accessor :row, :column, :cells, :cell_list

  def initialize(row, column)
    @row = row
    @column = column
    @cells = []
    @second_generation = []
    puts 'First Generation'
    initial_generation = create_generation
    first_generation = random_generation(initial_generation)
    print_universe(first_generation)
    second_generation = next_generation(first_generation)
    puts 'Second Generation'
    print_universe(second_generation)
  end

  def create_generation
    Array.new(@row) do |y|
      Array.new(@column) do |col|
        @x = Cell.new(col, y)
        @cells << @x
      end
    end
    @cells
  end

  def random_generation(generation)
    generation.each do |cell|
      random_life = [true, false].sample
      cell.alive = random_life
    end
  end

  def next_generation(generation)
    @temp_generation = generation
    @new_generation = create_generation
    @new_generation.each do |cell|
      cell.alives = live_neighbours_around_cell(cell).count
      print(cell.alives)
      if cell.alive
        if cell.alives < 2
          cell.die
        elsif [2, 3].include?(cell.alives)
          cell.alive
        elsif cell.alives > 3
          cell.alive
        else
          cell.die
        end
      elsif cell.alive && cell.lives > 3
        cell.revive!
      end
    end
    @new_generation
  end

  def print_universe(list)
    @alt = 0
    @result = @row * @column

    while @alt < @result
      @row.times do |number|
        list[number + @alt].paint
      end
      @alt += @row
    end
  end

  def live_cells
    @cells.select(&:alive)
  end

  def dead_cells
    @cells.select { |cell| cell.alive == false }
  end

  def live_neighbours_around_cell(cell)
    live_neighbours = []
    live_cells.each do |live_cell|
      live_neighbours << live_cell if live_cell.x == cell.x - 1 && live_cell.y == cell.y
      live_neighbours << live_cell if live_cell.x == cell.x - 1 && live_cell.y == cell.y + 1
      live_neighbours << live_cell if live_cell.x == cell.x && live_cell.y == cell.y + 1
      live_neighbours << live_cell if live_cell.x == cell.x + 1 && live_cell.y == cell.y + 1
      live_neighbours << live_cell if live_cell.x == cell.x + 1 && live_cell.y == cell.y
      live_neighbours << live_cell if live_cell.x == cell.x + 1 && live_cell.y == cell.y - 1
      live_neighbours << live_cell if live_cell.x == cell.x && live_cell.y == cell.y - 1
      live_neighbours << live_cell if live_cell.x == cell.x - 1 && live_cell.y == cell.y - 1
    end
    live_neighbours
  end
end

class Cell
  attr_accessor :x, :y, :alive, :dead, :alives, :die, :revive, :paint

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @alive = false
    @alives = 0
  end

  def alive?
    alive
  end

  def dead?
    !alive
  end

  def die!
    @alive = false
  end

  def revive!
    @alive = true
  end

  def paint
    if alive
      print '*'
    else
      print '.'
    end
  end
end

game = Game.new
