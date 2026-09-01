class Cat
  attr_accessor(:name, :age, :color)
  def initialize(name, age, color)
    @name = name
    @age = age
    @color = color
  end

  def meow
    puts "Meow!"
  end
end

cat1 = Cat.new("Whiskers", 3, "gray")
cat1.meow
puts cat1.age


puts cat1.name