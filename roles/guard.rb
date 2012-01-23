$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Guard < Role

  def initialize(base)
    super(base)
    @base.color   = Gosu::Color::RED
    @attack_ticks = 0
    @attack_delay = 200
  end

  def update
    super
    @dest = Point.near(queen) if at?(@dest) and rand(100) == 1
    @attack_ticks += 1
  end

  def encounter(mob)
    if can_attack?(mob) 
      attack(mob) 
    end
  end

  def attack(mob)
    #puts "#{name} is attacking #{mob.name} for #{@base.power}"
    mob.take_damage(@base.power)
    @attack_ticks = 0
  end

  def can_attack?(mob)
    @attack_ticks > @attack_delay and mob != queen and mob.queen != queen
  end

end
