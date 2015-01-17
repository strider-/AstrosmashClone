class HomingMissile < Meteor

    SPEED = 4.5

    def initialize(window:, speed: nil)
        super(window: window, image_name: 'missile.png')
        @color = Gosu::Color::WHITE
    end

    def update
        if touched_down? && !seek_after_touch_down?
            die!
        else
            move_to_player
        end
    end

    def size
        'missile'
    end

    def value
        50
    end

    def touched_down?
        y >= floor
    end        

    private

    def move_to_player
        vx, vy = vector_to_target_position(player_position)
        offset(vx * SPEED, vy * SPEED)
        set_y(floor) if y > floor
    end

    def seek_after_touch_down?
        @seek_after_touch_down ||= Gosu.random(0, 1000).truncate % 2 == 0        
    end

    def seek_x
        if touched_down?
            exit_x
        else
            window.player_position[0]
        end        
    end

    def player_position
        [seek_x, PlayState::FLOOR]
    end

    def floor
        @floor ||= (PlayState::FLOOR - image.height)
    end

    def exit_x
        @hard_x ||= if x <= window.player_position[0]
            window.width
        else
            -image.width
        end
    end
end