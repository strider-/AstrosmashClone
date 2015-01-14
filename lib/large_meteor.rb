class LargeMeteor < Meteor
    def size
        'large'
    end

    def value
        10
    end

    def split
        [
            Meteor.create_small(window, self, -1.5),
            Meteor.create_small(window, self, 1.5)
        ]
    end
end