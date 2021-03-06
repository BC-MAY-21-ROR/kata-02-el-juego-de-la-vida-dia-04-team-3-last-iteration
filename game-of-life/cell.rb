class Cell
  attr_accessor :x, :y, :alive, :dead, :neighbors, :die, :revive, :paint

  def initialize(x = 0, y = 0)
    @x = x
    @y = y
    @alive = false
    @neighbors = 0
  end

  def alive?() = alive

  def dead?() = !alive

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
