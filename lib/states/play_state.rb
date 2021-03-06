class PlayState < GameState
    attr_reader :lives, :score, :peak_score, :multiplier

    FLOOR               = 420 # smoke games every day
    DEATH_PENALTY       = 100
    EXTRA_LIFE_INTERVAL = 5000
    UFO_BREAKPOINT      = 20000
    EXTRA_DIFFICULTY    = 100000

    def initialize(window)
        super window
        @player = Player.new(window)
        @hud = Hud.new(window, self, @player)
        @meteor_shower = MeteorShower.new(window)
        @explosions = []
        @lives = 2
        @score, @peak_score = 0, 0
    end

    def update
        set_multiplier
        adjust_difficulty
        game_objects.each(&:update)
        clear_explosions
        collision_check
        set_ufo_status
    end

    def draw
        window.fill_rect(0, 0, window.width, FLOOR, bg_color)
        game_objects.each(&:draw)
    end

    def draw_hud
        @hud.draw
    end

    def button_down(id)
        if id == Gosu::KbP
            pause
        else
            @player.button_down(id)
        end  
    end

    def reset
        @meteor_shower.clear
        @explosions.clear
        @player.reset
    end

    def player_position
        @player.position
    end

    private

    def pause
        window.state = PauseState.new(window, self)
    end

    def clear_explosions
        @explosions.reject! do |explosion|
            explosion.done?
        end
    end

    def collision_check
        meteor_hits.each do |meteor|
            handle_shot_down meteor
        end

        ufo_bullet_hits.each do |bullet|
            bullet.was_shot_down!
            add_explosion *bullet.position
        end

        if player_was_hit? || @meteor_shower.spinner_crashed?
            you_died
        else
            decrement_score(@meteor_shower.crashed_meteor_value)
        end
    end

    def you_died
        @lives -= 1
        decrement_score(DEATH_PENALTY)
        window.state = DeathState.new(window, self)        
    end

    def handle_shot_down(meteor)
        @meteor_shower.clear_meteor meteor
        add_explosion *meteor.position
        increment_score meteor.value
    end

    def add_explosion(x, y)
        @explosions.push(Explosion.new(window, x, y))
    end

    def player_was_hit?
        meteor_struck_player? || ufo_bullet_struck_player?
    end

    def meteor_struck_player?
        @meteor_shower.meteors.any? do |meteor|
            @player.collides_with? meteor
        end 
    end

    def ufo_bullet_struck_player?
        @meteor_shower.ufo_bullets.any? do |bullet|
            @player.collides_with? bullet
        end        
    end

    def meteor_hits
        @meteor_shower.meteors.select do |meteor|
            @player.shot_down? meteor
        end
    end

    def ufo_bullet_hits
        @meteor_shower.ufo_bullets.select do |bullet|
            @player.shot_down? bullet
        end
    end

    def increment_score(value)
        @score += (value * @multiplier)
        if @peak_score < @score
            @lives += 1 if should_award_extra_life?
            @peak_score = @score
        end
    end

    def decrement_score(value)
        @score = [@score - (value * @multiplier), 0].max
    end

    def should_award_extra_life?
        (@peak_score % EXTRA_LIFE_INTERVAL) > (@score % EXTRA_LIFE_INTERVAL)
    end

    def set_ufo_status
       @score >= UFO_BREAKPOINT ? @meteor_shower.activate_ufo! : @meteor_shower.deactivate_ufo
    end

    def game_objects
        (@game_objects ||= [@hud, @player, @meteor_shower]) + @explosions
    end

    def set_multiplier
        @multiplier = case @score
        when 0..999
            1
        when 1000..4999
            2
        when 5000..19999
            3
        when 20000..49999
            4
        when 50000..99999
            5
        else
            6
        end
    end

    def adjust_difficulty
        bonus = [(@score / EXTRA_DIFFICULTY) - 1, 0].max
        @meteor_shower.difficulty = @multiplier + bonus
    end

    def bg_color
        case @multiplier
        when 2
            Gosu::Color.argb(0x55268BD2)
        when 3
            Gosu::Color.argb(0x55A57FBC)
        when 4
            Gosu::Color.argb(0x5566AABB)
        when 5
            Gosu::Color.argb(0x55D9D9D9)
        else
            Gosu::Color.argb(0x55555555)
        end
    end
end