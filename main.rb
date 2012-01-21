$: << File.expand_path(File.dirname(__FILE__))
require 'mob'
require 'food'
require 'egg'

class Game < Chingu::Window
  
  @@assets = File.expand_path(File.join(File.dirname(__FILE__), 'assets'))
  def self.assets; @@assets; end

  def initialize
    super(800,600)
    $window.cursor = true
    Point.set_bounds($window.width, $window.height)
    self.input = {:esc=>:exit, :space=>:debug}

    @bg   = Gosu::Image.new(self, "#{@@assets}/dirt_800x600.jpg")
    @mobs = []
    @food = []
    @eggs = []

    # add some stuff:
    100.times { @food << Food.new }
    4.times   { add_colony }
  end

  def debug
    add_colony
    puts "DEBUG: added a colony"
  end

  def update
    super
    update_mobs
    update_food
    update_eggs
    handle_collisions
    $window.caption = "FPS: #{$window.fps} food: #{@food.length} mobs: #{@mobs.length}"
  end

  def draw
    @bg.draw(0,0,0)
    @food.each { |food| food.draw }
    @eggs.each { |egg|   egg.draw }
    @mobs.each { |mob|   mob.draw }
  end

  ################
  ## eggs
  ################
 
  def update_eggs
    @eggs.each do |egg|
      egg.update
      if egg.ready_to_hatch?
        hatch_egg(egg) 
      elsif egg.eaten?
        @eggs.delete(egg)
      end
    end
  end

  def add_egg(egg)  
    @eggs << egg
  end

  def hatch_egg(egg)
    @eggs.delete(egg)
    mob   = Mob.new
    mob.x = egg.x
    mob.y = egg.y
    mob.set_queen(egg.queen)
    @mobs << mob
    puts "#{egg.name} has hatched into #{mob.role.name}"
  end

  ################
  ## mobs
  ################

  def update_mobs
    @mobs.each do |mob|
      mob.update
      @mobs.delete(mob) if mob.dead?
    end
  end

  def add_colony
    queen = Mob.new
    queen.set_role(:queen)
    @mobs << queen
    2.times do
      mob = Mob.new
      mob.set_role(:worker)
      mob.set_queen(queen)
      mob.set_position(queen)
      @mobs << mob
    end
  end

  ################
  ## food
  ################

  def update_food 
    add_food(5)
    @food.each do |food| 
      if food.eaten?
        @food.delete(food) 
        food.destroy
      end
    end
  end

  def add_food(total)
    if @food.length < total and rand(100) == 1
      @food << Food.new
    end
  end

  ################
  ## collisions
  ################
 
  def handle_collisions
    Mob.each_collision(Food) do |mob, food| 
      next if mob.dead?
      if mob.has_role?(:queen) or mob.has_role?(:worker)
        mob.role.collect(food) if food.collectable?
      end
    end

    Mob.each_collision(Mob) do |mob1, mob2|
      next if mob1.dead? or mob2.dead?
      mob1.encounter(mob2)
    end
  end
end

Game.new.show
