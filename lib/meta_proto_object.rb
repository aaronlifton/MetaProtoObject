module MetaProtoObject
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
      elsif e.length == 2
        h = Hash.new
        self.each do |e|
          h[e[0]] = e[1]
        end
      elsif e[0].length == 2 && e.class == Array
        self.map!(&:to_hash)
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
  # TODO
  class TypedNumeric
  end

  class TypedString
  end
end

# Object.extend(TypedObject)

