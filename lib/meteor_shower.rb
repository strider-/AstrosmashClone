class MeteorShower
    def initialize(window, play_state)
        @window = window
        @state = play_state
        @meteors = []
        @interval = 1000
        @last_addition = 0
    end

    def update
        @meteors.each(&:update)
        @meteors.reject! do |meteor|
            meteor.out_of_bounds?
        end
        make_it_rain
    end

    def draw
        @meteors.each(&:draw)
    end

    private

    def make_it_rain
        if time_for_more?
            @meteors.push(Meteor.new(@window))
            @last_addition = Gosu.milliseconds
        end
    end 

    def time_for_more?
        (Gosu.milliseconds - @last_addition) > @interval
    end
end