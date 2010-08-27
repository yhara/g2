require 'irb'
require 'lib/g2'

puts "test"

g2 :foo

#G2::UI::THREAD.join
IRB.start

