$: << File.expand_path(File.dirname(__FILE__))
require 'chingu'

class Node < Chingu::GameObject
  attr_accessor :z, :scale

  traits :collision_detection, :bounding_circle

  @@next_id  = 0
  @@defaults = { :x=>10, :y=>10 }

  def initialize(options={})
    super(@@defaults.merge(options))
    @id      = @@next_id; @@next_id += 1
    @x       = rand($window.width)
    @y       = rand($window.height)
    @z       = 2
    @scale   = 1
    @angle   = rand(360)
    @visible = true
  end

  def update
  end

  def draw
    if visible? and not @image.nil?
      puts "DEBUG: #{name} scale: #{@scale}" if @scale > 1
      @image.draw_rot(@x, @y, @z, @angle, 0.5, 0.5, @scale, @scale, @color, @mode) 
    end
  end

  def name
    "#{@id}_#{self.class.name.downcase}"
  end

  def visible?
    @visible
  end

  def hide!
    @visible = false
  end

  def show!
    @visible = true
  end

end
