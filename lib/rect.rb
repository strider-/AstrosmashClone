class Rect
    attr_reader :x, :y, :w, :h

    def initialize(x, y, w, h)
        @x, @y, @w, @h = x, y, w, h
    end

    def offset(x, y)
        @x += x
        @y += y
    end

    def move_to(x, y)
        @x = x
        @y = y
    end

    def intersects_with?(rect)
        return false unless rect.is_a?(Rect)
        (rect.x.between?(self.x, self.x2) && rect.y.between?(self.y, self.y2)) ||
        (self.x.between?(rect.x, rect.x2) && self.y.between?(rect.y, rect.y2))
    end

    def bounds
        [@x, @y, x2, y2]
    end

    def x2
        @x + @w
    end

    def y2
        @y + @h
    end
end