# encoding: UTF-8

module KernelExtensions
 def ø(klass)
    case klass
    when String
      ""
    when Fixnum
      0
    when Float
      0.0
    when Array
      []
    when Hash
      {}
    when NilClass
      nil
    end
  end
    
  alias :λ, :lambda
  
  def ∀(a, &blk)
    a.all? { |e| blk.call(e) == true }
  end

  def ∀t(a, klass)
    a.all? { |e| e.is_a?(klass) }
  end
  
  def ∃(a, &blk)
    a.any? { |e| blk.call(e) == true }
  end

  def ∃t(a, klass)
    a.any? { |e| e.is_a?(klass) }
  end

  def Δ(x, y)
    (x - y).abs
  end

  def π
    Math::PI
  end

  def ƒ(a, &blk)
    a.fold(&blk)
  end

  def ∫(a)
    a.fold {|x,y| x + y}
  end
end


module Kernel
  include KernelExtensions
end

module MetaProtoObject

  def ≠(x)
    self != x
  end

  def ≈(x)
    self == x || self == x * 1.0 || self == x.ceil || self == x.floor
  end

  # Returns an instance of an Object's Metaclass
  def metaclass
    class << self; self; end;
  end

  # Evaluates a block on the instance of the Object's Metaclass
  def meta_eval
    metaclass.instance_eval
  end

   # Adds methods to a metaclass
   def meta_def(name, &blk)
     meta_eval { define_method name, &blk }
   end

   # Defines an instance method within a class
   def class_def(name, &blk)
     class_eval { define_method name, &blk }
   end

  # Turns the Object's Class into a Singleton
  def singletonify
    class_eval { include Singleton }
  end

  # Turns the Object's Metaclass into a Singleton
  def meta_singletonify
    meta_eval { include Singleton }
  end

  # Turns the Object instance into a size n array of itself
  def replicate(n)
    Array.new(n) {
      self
    }
  end
  def to_a(n = 1);replicate(n);end;

  # x: Array[Symbol]
  def delete_methods(x = [], global = false)
    x = self.instance_methods(false) if x.empty?
    x.each do |meth|
      remove_method meth.to_sym
      undef meth.to_sym if global
    end
  end
end

class Array
  def to_hash
    h = Hash.new
    if self.any? {|e| !e.is_a?(Array)}
      self.each_with_index do |e, i|
        h[i] = e
      end
    else
      if self.any? {|e| e.length != 2 && e.class != Array}
        raise ArgumentError, "Length of all arrays and sub-arrays must equal 2" 
      elsif e[0].is_a?(Array) && e[0].length == 2 && e.class == Array
        self.map!(&:to_hash)
      elsif e.length == 2
        self.each do |e|
          h[e[0]] = e[1]
        end
      end
    end

    h
  end
end

class Hash
  def to_a
    Array.new.tap do |a|
      self.each do |k, v|
        a << [k, v]
      end
    end
  end

  def stringify
    self.map { |k,v| [ k.to_s, v.to_s ] } ]
  end

  def symbolize
    self.map { |k,v| [ k.to_sym, v.to_sym ] } ]
  end
end

Object.extend(MetaProtoObject)

module TypedObject
  # Symbol, Class
  def type_check_method(meth, type)

    # here we dynamically define accessor methods
    define_method(meth) do
      # unfortunately you have to add the @ here, so string interpolation comes to help
      instance_method(meth)
    end

    class_def("#{meth.to_s}=") do |value|
      # simply check a type and raise an exception if it's not what we want
      # since this type of Ruby block is a closure, we don't have to store the 
      # 'type' variable, it will 'remember' it's value 
      if value.is_a? type
        define_method(meth.to_s, value)
      else
        raise ArgumentError.new("Invalid Type")
      end
    end
  end
  
  # String, Class
  def type_check_attr(name, type)

    # here we dynamically define accessor methods
    define_method(name) do
      # unfortunately you have to add the @ here, so string interpolation comes to help
      instance_variable_get("@#{name}")
    end

    define_method("#{name}=") do |value|
      # simply check a type and raise an exception if it's not what we want
      # since this type of Ruby block is a closure, we don't have to store the 
      # 'type' variable, it will 'remember' it's value 
      if value.is_a? type
        instance_variable_set("@#{name}", value)
      else
        raise ArgumentError.new("Invalid Type")
      end
    end
  end
end

Object.extend(TypedObject)
