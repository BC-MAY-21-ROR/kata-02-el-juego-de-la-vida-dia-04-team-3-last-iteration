class Cell
  attr_accessor :x, :y, :alive, :dead, :alives, :die, :revive, :paint

  def initialize(x, y)
    @x = x
    @y = y
    @alive = false
    @alives = 0
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
