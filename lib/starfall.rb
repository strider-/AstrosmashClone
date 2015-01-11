class Starfall
    MAX_STARS = 50

    def initialize(window)
        @window = window
        @stars = []
        @active = true
    end

    def update
        if @active
            @stars.each(&:update)
            @stars.reject! do |star|
                star.out_of_bounds?
            end
            ensure_star_count
        end
    end

    def draw
        if @active
            @stars.each(&:draw)
        end
    end

    def destroy
        @active = false
        @stars = nil
    end

    private

    def ensure_star_count
        [(MAX_STARS - @stars.count), 5].min.times do |i|
            @stars.push Star.new(@window)
        end
    end
end