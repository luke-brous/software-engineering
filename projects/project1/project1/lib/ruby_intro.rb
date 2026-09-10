# When done, submit this file on Brightspace.

# Part 1

def sum(arr)
  # YOUR CODE HERE
  arr.sum
end

def max_2_sum(arr)
  # YOUR CODE HERE
  arr.max(2).sum
  
end

def sum_to_n?(arr, n)
  # YOUR CODE HERE
  # store in a hash map, then minus target from curr number 
  # and see if num is in hash map 
  seen = {}
  arr.each do |num|
    
    diff = n - num
    if seen.key?(diff)
      return true
    end

    if seen.key?(num) == false
      seen[num] = true
    end
  end

  return false

end

# Part 2

def hello(name)
  # YOUR CODE HERE
  return "Hello, #{name}"
end

def starts_with_consonant?(s)
  # YOUR CODE HERE
  return s.match?(/\A[^aeiou]/i) && s.match?(/\A[a-z]/i)
end

def binary_multiple_of_4?(s)
  # YOUR CODE HERE
  if s.match?(/\A[0-9]+\z/) && (s.to_i(2) % 4) == 0
    return true
  else
    return false
  end
end

# Part 3

class BookInStock
  # YOUR CODE HERE
  attr_accessor :isbn
  attr_accessor :price


  def initialize(isbn, price)
    raise ArgumentError, "ISBN number is empty" if isbn.length == 0
    raise ArgumentError, "Price must be higher than 0" if price <= 0

    @isbn = isbn
    @price = price
  end

  def price_as_string()
    return "$%.2f" % [@price]
  end
end