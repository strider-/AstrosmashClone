class Spinner < Meteor
    ROTATE_ORIGIN = 0.5

    def initialize(window, size_factor)
        super(window, 'spinner.png')
        @step_y = Gosu.random(1.0, 3.5)
        @step_a = Gosu.random(2, 7)
        @angle  = 0
        @size_factor = size_factor
        @hit_box = Rect.new(@x, @y, @image.width * @size_factor, @image.height * @size_factor)
        adjust_hit_box_for_rotation
    end

    def update
        @y += @step_y
        @angle += @step_a
        @hit_box.offset(0, @step_y)
    end

    def draw
        @image.draw_rot(*position, -1, @angle, 
                        ROTATE_ORIGIN, ROTATE_ORIGIN, 
                        @size_factor, @size_factor, Gosu::Color::WHITE)
        draw_hit_box if SHOW_HITBOX
    end

    def size
        'spinner'
    end

    private

    def adjust_hit_box_for_rotation
        @hit_box.offset(-(@image.width * ROTATE_ORIGIN * @size_factor), 
                        -(@image.height * ROTATE_ORIGIN * @size_factor))
    end
end