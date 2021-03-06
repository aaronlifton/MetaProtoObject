# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), 'meta_proto_object.rb')

p ø(String) == ""
p ø(Fixnum) == 0
x = λ {|y| y + 1 }
p x[2]
y = λ {|x, y| x + y}
p y[1,2]
z = L {|x| ƒ(x) {|x,y| x + y}}
p z[[1,2]]


p ƒ [1,2,3,4] {|x,y| x + y}
p fold [1,2,3,4] {|x,y| x + y}

p ∀ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
p ∃ [1,2,"cat",3] { |e| e.is_a?(Fixnum) }
p ∃t [1,2,"cat",3], Fixnum