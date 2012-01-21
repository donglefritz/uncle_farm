$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Medic < Role

  def initialize(base)
    super(base)
    @base.color = Gosu::Color::BLUE
  end

  def update
    super
    @dest = Point.random if at?(@dest) and rand(100) == 1
  end

end
