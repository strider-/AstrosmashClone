class SmallMeteor < Meteor
    def initialize(window, parent_meteor = nil, step_x = nil)
        super window 
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
        @x, @y   = parent.position        
        @step_y  = parent.step_y
        @step_x  = step_x
        @color   = parent.color
        @hit_box.move_to(@x, @y)
    end
end