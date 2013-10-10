# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), 'meta_proto_object.rb')

puts ø(String) == ""
puts ø(Fixnum) == 0
x = λ {|y| y + 1 }
puts x[2]

puts ∀ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
puts ∃ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
puts ∃t [1,2,"cat",3], Fixnum