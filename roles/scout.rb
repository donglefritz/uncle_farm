$: << File.expand_path(File.dirname(__FILE__))
require 'role'

class Scout < Role 

  def initialize(base)
    super(base)
    @base.color  = Gosu::Color::GREEN
    @intel       = nil
    @learn_speed = 300
    @learn_ticks = 0
  end

  def update
    @learn_ticks += 1
    if @intel.nil? 
      @dest = Point.random if at?(@dest)
    elsif at?(@dest)
      @base.queen.role.learn(@intel, name) if not @base.queen.nil?
      @intel = nil
    end
    super
  end

  def encounter(mob)
    if @intel.nil? and @learn_ticks > @learn_speed and not @base.queen.nil? and mob.has_role?(:queen)
      @intel = Point.new(mob.x, mob.y)
      @dest  = Point.new(@base.queen.x, @base.queen.y)
      puts "#{name} just gathered some intel on #{mob.role.name}"
      @learn_ticks = 0
    end
  end
      


end
