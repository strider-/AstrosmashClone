class SmallSpinner < Spinner
    def initialize(window:, speed: nil)
        super(window: window, size_factor: 0.5, speed: speed)
    end

    def value
        80
    end    
end