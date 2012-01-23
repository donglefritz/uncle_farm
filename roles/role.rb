require 'chingu'

class Role
  attr_accessor :image, :color
  attr_reader :starting_health, :starting_power, :starting_speed

  def initialize(base)
    @base  = base
    @dest  = Point.new(base.x, base.y)
    image  = "#{Game.assets}/ant_anim_6x40.png"
    @anim  = Chingu::Animation.new(:file=>image, :size=>40)
    @base.image      = @anim.first
    @starting_health = 1
    @starting_power  = 1
    @starting_speed  = rand(8) + 2
  end

  #####################
  ## interface methods:
  #####################

  def update
    move_towards(@dest) if @dest
  end

  def encounter(mob)
  end

  def associate(mob)
  end
  
  def disassociate(mob)
  end

  def die
  end

  #####################
  ## @base Helpers:
  #####################

  def move_towards(dest)
    if @base.move_towards(dest)
      @base.image = @anim.next if @anim
    end
  end

  def name
    "#{@base.name} (#{self.class.name.downcase})"
  end

  def queen
    @base.queen
  end

  def at?(point)
    @base.at?(point)
  end

  def x
    @base.x
  end

  def x=(value)
    @base.x = value
  end
  
  def y
    @base.y
  end

  def y=(value)
    @base.y = value
  end

  def z
    @base.z
  end

  def z=(value)
    @base.z = value
  end

end

