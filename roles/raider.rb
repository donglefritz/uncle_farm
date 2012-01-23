$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Raider < Role

  def initialize(base)
    super(base)
    @base.color      = Gosu::Color::CYAN
    @attack_ticks    = 0
    @raid_ticks      = 0
    @attack_delay    = 200
    @raid_length     = 2000
    @raid_dest       = nil
    @is_raiding      = false
  end

  def update
    super
    @raid_ticks   += 1
    @attack_ticks += 1

    if @raid_dest.nil? 
      @dest = Point.near(@base.queen) if at?(@dest) and rand(100) == 1
    else
      if @raid_ticks > @raid_length
        @dest       = Point.near(@base.queen)
        @is_raiding = false
        @raid_ticks = 0
        puts "#{name} is done raiding"
      else
        @dest = Point.near(@raid_dest) if at?(@dest)
      end
    end
  end

  def encounter(mob)
    if can_attack?(mob) 
      attack(mob) 
    end
  end

  def raid(point)
    puts "#{name} is going to raid at #{point.x},#{point.y}"
    @raid_dest  = point
    @raid_ticks = 0
    @is_raiding = true
  end

  def raiding?
    @is_raiding
  end

  def attack(mob)
    puts "#{name} is attacking #{mob.role.name} for #{@base.power}"
    mob.take_damage(@base.power)
    @attack_ticks = 0
  end

  def can_attack?(mob)
    @attack_ticks > @attack_delay and mob != queen and mob.queen != queen
  end

end
