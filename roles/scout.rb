$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Scout < Role 

  def initialize(base)
    super(base)
    @base.color = Gosu::Color::GREEN
  end

  def update
    @dest = Point.random if at?(@dest) and rand(100) == 1
    super
    "the scout searches the surrounding area"
  end

end
