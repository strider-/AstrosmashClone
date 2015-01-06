#!/home/mtighe/.rubies/ruby-2.1.2/bin/ruby -w

require 'gosu'

Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each do |file| 
    require file
end

Astrosmash.new.show