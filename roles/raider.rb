$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Raider < Role 

  def initialize(base)
    super(base)
    @base.color = Gosu::Color::YELLOW
  end

  def update
    @dest = Point.random if at?(@dest) and rand(100) == 1
    super
  end

end
