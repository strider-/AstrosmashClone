module Collidable
    attr_reader :hit_box, :x, :y, :image, :window

    def initialize(window, image_name)
        @window = window
        load_image(image_name)
    end

    def update; end

    def draw;   end

    def offset(x, y)
        @x += x
        @y += y
        @hit_box.offset(x, y)
    end

    def set_hit_box(x, y, w, h)
        @hit_box = Rect.new(x, y, w, h)
    end

    def collides_with?(obj)
        if obj.is_a?(Rect)
            @hit_box.collides_with?(obj)
        elsif obj.is_a?(Collidable)
            @hit_box.collides_with?(obj.hit_box)
        else
            false
        end
    end

    def x=(x)
        @x = x
        move_hit_box(@x, @y)
    end

    def y=(y)
        @y = y
        move_hit_box(@x, @y)
    end

    def position
        [@x, @y]
    end

    def hit_box_color
        Gosu::Color.argb(0x7AFF7A7A)
    end

    private

    def button_down?(id)
        @window.button_down?(id)
    end

    def load_image(name)
        @image = @window.load_image(name)
        @x, @y = start_position
        set_hit_box(@x, @y, @image.width, @image.height)
    end

    def start_position
        [0, 0]
    end

    def move_hit_box(x, y)
        @hit_box.move_to(@x, @y)
    end

    def draw_hit_box
        @window.fill_rect(*@hit_box.bounds, hit_box_color) if SHOW_HITBOX
    end
end