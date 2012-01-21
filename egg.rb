$: << File.expand_path(File.dirname(__FILE__))
require 'resource'

class Egg < Resource
  attr_reader :queen

  def initialize(queen)
    super()
    @queen = queen
    position_near_queen
    @image = Gosu::Image.new($window, "#{Game.assets}/egg.png")
    @ticks = rand(200) + 100
  end

  def update
    @ticks -= 1
  end

  def ready_to_hatch?
    @ticks < 1
  end

  def get_eaten
    get_used
  end

  def eaten?
    used?
  end

  def position_near_queen
    x = rand(20) + 10
    y = rand(20) + 10
    x *= rand(2)==1 ? 1 : -1
    y *= rand(2)==1 ? 1 : -1
    @x = @queen.x + x
    @y = @queen.y + y
  end

end
