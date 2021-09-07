class Generation
  attr_writer :row, :col, :cells
  attr_accessor :result

  def initialize(row, col)
    @row = row
    @col = col
    @cells = []
    @result = result
  end

  def create_generation
    @row.times do |first_round|
      @col.times do |second_round|
        @cells << Cell.new(second_round, first_round)
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
    row = @row
    col = @col
    alt = 0
    result = row * col
    while alt < result
      @row.times do |number|
        list[number + alt].paint
      end
      alt += row
      puts "\t"
    end
  end

  def next_generation(generation)
    current = []

    generation.each do |cell|
      cell.neighbors = live_neighbours_around_cell(cell).count

      if cell.alive? && cell.neighbors < 2
        cell.die!
        current << cell
      end

      if cell.alive? && ([2, 3].include? cell.neighbors)
        cell.revive!
        current << cell
      end

      if cell.alive? && cell.neighbors > 3
        cell.die!
        current << cell
      end

      if cell.dead? && cell.neighbors == 3
        cell.revive!
        current << cell
      end
    end
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
