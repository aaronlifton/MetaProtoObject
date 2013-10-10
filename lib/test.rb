# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), 'meta_proto_object.rb')

p ø(String) == ""
p ø(Fixnum) == 0
x = λ {|y| y + 1 }
p x[2]
y = λ {|x, y| x + y}
p y[1,2]

p ∀ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
p ∃ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
p ∃t [1,2,"cat",3], Fixnum