class Generation
  attr_accessor :row, :col, :cells, :cell_list

  def initialize(row, col, x)
    @row = row
    @col = col
    @cells = []
    @x = x
  end

  def create_generation
    Array.new(@row) do |y|
      Array.new(@col) do |colum|
        @x = Cell.new(colum, y)
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

  def print_universe(list)
    @alt = 0
    @result = @row * @col

    while @alt < @result
      @row.times do |number|
        list[number + @alt].paint
        print '  '
      end
      @alt += @row
      puts "\t"
    end
  end

  def next_generation(generation)
    @temp_generation = generation

    next_round = []

    @temp_generation.each do |cell|
      cell.alives = live_neighbours_around_cell(cell).count
     
      if cell.alive? &&  cell.alives < 2
        cell.die!
        next_round << cell
      end

      if cell.alive? && ([2, 3].include?  cell.alives)
        cell.revive!
        next_round << cell
      end

      if cell.alive? &&  cell.alives > 3
        cell.die!
        next_round << cell
      end

      if cell.dead? &&  cell.alives == 3
        cell.revive!
        next_round << cell
      end

    end

    pp next_round
    pp generation

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

  def live_cells
    @cells.select(&:alive)
  end

  def dead_cells
    @cells.select { |cell| cell.alive == false }
  end
end
