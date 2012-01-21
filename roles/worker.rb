$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Worker < Role 

  def initialize(base)
    super(base)
    @base.color = Gosu::Color::BLACK
    @collected  = nil
  end

  def update
    super
    if @collected.nil?
      @dest = Point.random if at?(@dest) and rand(50) == 1
    elsif queen.nil?
        @collected.get_dropped
        @collected = nil
    elsif at?(queen)
        give(queen)
    else
      @dest        = queen
      @collected.x = x
      @collected.y = y
    end
  end

  def collect(resource)
    if @collected.nil?
      @collected   = resource.get_collected 
      @collected.z = z + 1
      puts "#{name} collected #{resource.name}"
    end
  end

  def give(mob)
    mob.role.take(@collected) unless @collected.nil?
    puts "#{name} gave #{@collected.name} to #{mob.name}"
    @collected = nil
  end

end
