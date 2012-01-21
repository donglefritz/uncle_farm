$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Queen < Role

  def initialize(base)
    super(base)
    @starting_health = 1
    @base.scale      = 1
    @base.color      = Gosu::Color::WHITE
    @home            = Point.random
    @energy          = 3
    @egg_cost        = 3
    @egg_ticks       = 0
    @mobs            = []
  end

  def update
    super
    @egg_ticks += 1
    if @egg_ticks > 3000
      @home = Point.random 
      @egg_ticks = 0
    end
    @dest = Point.near(@home) if at?(@dest) and rand(100) == 1
    lay_egg if @energy >= @egg_cost and @egg_ticks > 300
  end

  def associate(mob)
    @mobs << mob if not @mobs.include?(mob)
  end

  def disassociate(mob)
    @mobs.remove(mob)
  end

  def die
    super
    @mobs.each { |mob| mob.disassociate(self) }
    @mobs.clear
  end

  def wander
    x = rand(20)
    y = rand(20)
    x *= rand(2)==1 ? 1 : -1
    y *= rand(2)==1 ? 1 : -1
    @dest.x += x
    @dest.y += y
  end

  def take(food)
    @energy += food.value
    food.get_eaten
    puts "#{name} has eaten and now has #{@energy} energy"
  end

  def collect(resource)
    take(resource)
  end

  def lay_egg
    @energy -= @egg_cost
    egg = Egg.new(@base)
    $window.add_egg(egg)
    puts "#{name} just laid #{egg.name}"
    @egg_ticks = 0
  end

end
