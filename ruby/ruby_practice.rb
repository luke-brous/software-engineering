=begin
fruit1 = "strawberry"
fruit2 = "banana"
puts fruit1.reverse
puts fruit2.reverse!
fruit1 + " " + fruit2
=end

=begin
class String
  @@hello = "hi there!"
  def hello; "world"; end
end
puts "smoothie".hello
=end

=begin
class Fruit
  def method_missing(meth)
    if meth.to_s =~ /^tastes_(.*)\?$/
      "Yup, that fruit tastes #{$1}!"
    else
      super
    end
  end
end
orange = Fruit.new
puts orange.tastes_sour?
puts orange.tastes_sweet?
puts orange.bitter?
=end

=begin
def fib(n)
  a = 0
  b = 1
  for i in 0...n
    yield a
    temp = b
    b = a + b
    a = temp
  end
end
  
fib(10) { |x| puts x }
=end

=begin
class Array
  def odds()
    (1...self.length).step(2) { |i| yield self[i] }
  end
end

[1,2,3,4,5,6,7,8,9].odds { |x| puts x }
=end

words = ["hello", "world", "this", "is", "ruby", nil, ""]

