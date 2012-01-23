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
    @intel           = []
  end

  def update
    super
    @egg_ticks += 1
    if @egg_ticks > 3000
      @home = Point.random 
      @egg_ticks = 0
    end
    @dest = Point.near(@home) if at?(@dest) and rand(100) == 1
    lay_egg      if @energy >= @egg_cost and @egg_ticks > 300
    send_raiders if @intel.length > 0
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

  def take(food)
    @energy += food.value
    food.get_eaten
    #puts "#{name} has eaten and now has #{@energy} energy"
  end

  def learn(intel, scout_name)
    @intel << intel
    puts "#{name} just learned some intel from #{scout_name}"
  end

  def send_raiders
    @intel.each do |dest|
      @mobs.each do |mob|
        if mob.has_role?(:raider)
          if not mob.role.raiding?
            mob.raid(dest) 
            @intel.delete(dest)
            puts "#{name} just sent #{mob.role.name} to raid at #{dest.x},#{dest.y}"
          end
        end
      end
    end
  end

  def collect(resource)
    take(resource)
  end

  def lay_egg
    @energy -= @egg_cost
    egg = Egg.new(@base)
    $window.add_egg(egg)
    #puts "#{name} just laid #{egg.name}"
    @egg_ticks = 0
  end

end
