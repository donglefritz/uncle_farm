$: << File.expand_path(File.dirname(__FILE__))
require 'node'

class Resource < Node
  attr_reader :value

  def initialize
    super
    @image     = Gosu::Image.new($window, "#{Game.assets}/food.png")
    @value     = 1
    @collected = false
    @is_used   = false
  end

  def get_used
    @is_used = true
  end

  def used?
    @is_used
  end

  def get_collected
    @collected = true
    self
  end

  def get_dropped
    @collected = false
    self
  end

  def collectable?
    not @collected
  end

end
