class Spinner < Meteor
    ROTATE_ORIGIN = 0.5

    def initialize(window:, size_factor:, speed: nil)
        super(window: window, image_name: 'spinner.png')
        @step_y = speed || Gosu.random(1.0, 3.5)
        @step_a = Gosu.random(2, 7)
        @angle  = 0
        @size_factor = size_factor
        adjust_for_rotating_hit_box
    end

    def update
        @angle += @step_a
        offset(0, @step_y)
    end

    def draw
        image.draw_rot(*position, -1, @angle,
                        ROTATE_ORIGIN, ROTATE_ORIGIN,
                        @size_factor, @size_factor, Gosu::Color::WHITE)
        draw_hit_box
    end

    def size
        'spinner'
    end

    private

    def adjust_for_rotating_hit_box
        set_hit_box(
            self.x - (image.width * ROTATE_ORIGIN * @size_factor),
            self.y - (image.height * ROTATE_ORIGIN * @size_factor),
            image.width * @size_factor,
            image.height * @size_factor
        )
    end
end