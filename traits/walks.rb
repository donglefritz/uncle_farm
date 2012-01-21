
module Chingu
  module Traits
    module Walks

      def update_trait
        super
        return nil if respond_to?('dead?') and dead?
        if rand(50) == 1
          if rand(2) == 1
            @angle += rand(5)
          else
            @angle -= rand(5)
          end
        end
      end

      def warp(x=0,y=0)
        @x, @y = x, y
      end

      def face(point)
        @angle = Gosu::angle(@x, @y, point.x, point.y).to_i
      end

      def walk
        if rand(5) > 0
          @x += Gosu::offset_x(@angle, 0.5) * speed
          @y += Gosu::offset_y(@angle, 0.5) * speed
          @x += rand(2)==1 ? 1 : -1
          @y += rand(2)==1 ? 1 : -1
        end
      end

      def move_towards(point)
        if not at?(point)
          face(point)
          walk 
          return true
        end
        false
      end

      def at?(point)
        return true if point.nil?
        distance    = Gosu::distance(@x, @y, point.x, point.y).to_i
        half_height = self.height * self.scale * 0.5
        half_width  = self.width  * self.scale * 0.5
        distance < half_height or distance < half_width
      end


    end
  end
end
