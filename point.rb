
class Point
  attr_accessor :x, :y
  @@max_x  = 640
  @@max_y  = 480

  def initialize(x=0,y=0)
    @x = x
    @y = y
  end

  def desc
    Point.desc(self)
  end

  def self.random(game_object=nil)
    point = Point.new(Random.rand(@@max_x+1), Random.rand(@@max_y+1))
    apply_offset(point, game_object) if game_object
    point
  end

  def self.set_bounds(x=640, y=480)
    @@max_x = x
    @@max_y = y
    puts "INFO: Point bounds set to: #{@@max_x}, #{@@max_y}"
  end

  def self.desc(point)
    "#{point.x},#{point.y}"
  end
      
  def self.near(point=nil, max_distance=50)
    point = self.random if point.nil?
    x = rand(max_distance)
    y = rand(max_distance)
    x *= rand(2)==1 ? 1 : -1
    y *= rand(2)==1 ? 1 : -1
    Point.new(point.x+x, point.y+y)
  end

  private
  def self.apply_offset(point, game_object)
    min_x = game_object.width/2
    max_x = @@max_x - game_object.width/2
    min_y = game_object.height/2
    max_y = @@max_y - game_object.width/2
    point.x += min_x if point.x < min_x
    point.x -= min_x if point.x > max_x
    point.y += min_y if point.y < min_y
    point.y -= min_y if point.y > max_y
  end
end
