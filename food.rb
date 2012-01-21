$: << File.expand_path(File.dirname(__FILE__))
require 'resource'

class Food < Resource

  def initialize
    super
    @image = Gosu::Image.new($window, "#{Game.assets}/food.png")
  end

  def get_eaten
    get_used
  end

  def eaten?
    used?
  end

end
