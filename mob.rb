$: << File.expand_path(File.dirname(__FILE__))
require 'point'
require 'node'
require 'roles/worker'
require 'roles/scout'
require 'roles/guard'
require 'roles/medic'
require 'roles/raider'
require 'roles/queen'
require 'traits/walks'

class Mob < Node
  attr_reader :health, :power, :speed, :role, :death_ticks, :queen

  trait :walks
 
  @@roles          = Hash.new
  @@roles[:queen]  = Proc.new { |mob| Queen.new(mob)  }
  @@roles[:worker] = Proc.new { |mob| Worker.new(mob) }
  @@roles[:guard]  = Proc.new { |mob| Guard.new(mob)  }

  def initialize(options={})
    super(options)
    set_role(@@roles.keys[rand(@@roles.length)])
    @death_ticks = 0
  end

  def update
    super
    @death_ticks += 1 if dead?
    @role.update if @role
  end

  def encounter(mob)
    @role.encounter(mob) if @role
  end

  def associate(mob)
    @role.associate(mob) if @role
  end

  def has_role?(role_name)
    @role.class.name.downcase.to_sym == role_name.downcase.to_sym
  end

  def take_damage(amount)
    @health -= amount
    puts "#{name} took #{amount} damage and now has #{@health}"
    die if dead?
  end

  def dead?
    @health < 1
  end

  def die
    puts "#{name} has died"
    @role.die if @role
    if not @queen.nil?
      @queen.disassociate(self) 
      self.disassociate(@queen)
    end
  end

  def disassociate(queen)
    @queen = nil
  end

  def set_role(role_name)
    @role   = @@roles[role_name].call(self)
    @health = @role.starting_health
    @power  = @role.starting_power
    @speed  = @role.starting_speed
  end

  def set_position(point)
    @x = point.x
    @y = point.y
  end

  def set_queen(queen)
    @queen = queen
    @queen.associate(self)
  end

  def desc
    "#{name} (#{@x},#{@y}): angle: #{@angle}, health: #{@health}, power: #{@power}, speed: #{@speed}, image: #{@image}"
  end


end
