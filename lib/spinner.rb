class Spinner < Meteor
    ROTATE_ORIGIN = 0.5

    def initialize(window)
        super(window, 'spinner.png')
        @step_y = Gosu.random(1.0, 3.5)
        @step_a = Gosu.random(2, 7)
        @angle  = 0
        @factor = [1.0, 0.5].sample
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
                        @factor, @factor, Gosu::Color::WHITE)
    end

    def size
        'spinner'
    end

    def value
        100
    end

    private

    def adjust_hit_box_for_rotation
        @hit_box.offset(-(@image.width * ROTATE_ORIGIN), -(@image.height * ROTATE_ORIGIN))
    end
end