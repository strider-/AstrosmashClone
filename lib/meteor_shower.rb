class MeteorShower
    attr_reader :meteors

    TYPES = [
        LargeMeteor,  SmallMeteor, 
        LargeSpinner, SmallSpinner
    ]

    def initialize(window)
        @window = window
        @meteors = []
        @interval = 500
        @last_addition = 0
    end

    def update
        @meteors.each(&:update)
        @spinner_crashed = @meteors.any? { |m| m.crashed? && m.spinner? }
        @crashed_meteor_values = @meteors.select { |m| m.crashed? }.map(&:value)
        @meteors.reject! do |meteor|
            meteor.crashed? || meteor.out_of_bounds?
        end
        make_it_rain
    end

    def draw
        @meteors.each(&:draw)
    end

    def clear_meteor(meteor)
        @meteors.delete(meteor)
        @meteors.push(*meteor.split) if meteor.should_split?
    end
    
    def crashed_meteor_value
        (@crashed_meteor_values.inject(:+) || 0) / 2
    end

    def clear
        @meteors.clear
    end

    def spinner_crashed?
        @spinner_crashed
    end

    private

    def make_it_rain
        if time_for_more?
            @meteors.push random_meteor
            @last_addition = Gosu.milliseconds
        end
    end

    def random_meteor
        TYPES[Gosu.random(0, TYPES.count).truncate].new(@window)
    end  

    def time_for_more?
        time_since_last_meteor > @interval
    end

    def time_since_last_meteor
       Gosu.milliseconds - @last_addition
    end
end