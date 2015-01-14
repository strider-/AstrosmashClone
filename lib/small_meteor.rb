class SmallMeteor < Meteor
    def initialize(window:, parent_meteor: nil, step_x: nil, speed: nil)
        super(window: window, speed: speed)
        inherit_from_parent(parent_meteor, step_x) unless parent_meteor.nil?
    end

    def size
        'small'
    end

    def value
        20
    end    

    private

    def inherit_from_parent(parent, step_x)   
        self.x, self.y = parent.position     
        @step_y  = parent.step_y
        @step_x  = step_x
        @color   = parent.color
    end
end