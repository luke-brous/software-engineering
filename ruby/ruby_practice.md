# Ruby Practice Exercises

## What Would Ruby Do?

Given the following snippets of Ruby code, determine the output. If you can, find a classmate, discuss, then validate
your solutions by typing the code into an interpreter. You should alternate who types and who explains the output.

Code Snippet 1
```ruby
fruit1 = "strawberry"
fruit2 = "banana"
puts fruit1.reverse
puts fruit2.reverse!
fruit1 + " " + fruit2
```

Record the output of Code Snippet 1 in the block below.  

Output 1
```
yrrebwarts
ananab
```

reverse the  strawberry and banana strings

Briefly explain the output.

__Explanation 1 here__

Code Snippet 2
```ruby
class String
  @@hello = "hi there!"
  def hello; "world"; end
end
puts "smoothie".hello
```

Output 2
```
world
```

__Explanation 2 here__

Code Snippet 3
```ruby
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
```

Output 3
```
Yup, that fruit tastes sour!
Yup, that fruit tastes sweet!
ruby_practice.rb:22:in 'Fruit#method_missing': undefined method 'bitter?' for an instance of Fruit (NoMethodError)
        from ruby_practice.rb:29:in '<main>'
```

__Explanation 3 here__'
the method missing takes a method that starts with tastes_ and then adds the end of the method and adds it to the output. bitter doesnt work because it doesn't have tastes_ at the front


## Collections

In this next part, try to rewrite each of the following methods as one (short) line. One person should be the
writer, while the other person explains what to write. Try alternating roles between the two exercises. (*Hint: see
Figure 2.11 in the textbook.*)

Method 1
```ruby
def foo(arr)
  res = 0
  arr.each do |n|
    res += n 
  end
  res
end
```

One-liner 1
```
def foo(arr) = arr.sum
```

Method 2
```ruby
def bar(hsh)
  res = {}
  hsh.each do |k, v|
    if v > 100
      res[k] = v 
    end
  end
  res
end
```

One-liner 2
```
def bar(hsh) = hsh.select { |k, v| v > 100 }
```

## Iterators

In this part, create your own iterators with the yield statement that return the following elements. Again, alternate
roles between the two exercises.

Write a function fib(n) that yields the first n Fibonacci numbers in sequence.

Example use:
```
>> fib(4) { |x| puts x }
1
1
2
3
```

Your code for fib(n):
```ruby

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
  

```

Write the function Array#odds which yields the odd-indexed elements of the array in sequence.

Example use:
```
>> [10, 30, 50, 70, 90].odds do |n|
..   puts n
.. end
30
70
```
Your code for Array#odds:
```ruby
class Array
  def odds()
    (1...self.length).step(2) { |i| yield self[i] }
  end
end

```

## Collection Methods

Write 1 to 3 lines of Ruby code for each of the following tasks.  Don't use any explicit looping (for, loop, each, while, etc.):  use only the collection operators, most of which are defined in the module `Enumberable`.  (*An extra hint:  the primary keyword you're going to be using is* `compact` *.  Definitely look up the documentation online if you're not familiar with it!*)

Assuming the variable `words` is an array in which each element is either a string (which may be empty) or `nil`,
write a short amount of Ruby code that will return:

A copy of words with nil elements removed.
```ruby
words.compact

```

A copy of words with both nil and empty string elements removed.
```ruby
words.compact
words.reject { |x| x.empty?}
```

Only those words that are exactly 3 letters long.
```ruby
words.compact.select { |x| x.length == 3 }
```
Only those words that contain at least one vowel (a, e, i, o, u).
```ruby
vowels = ["a", "e", "i", "o", "u"]
words.compact.select { |x| x.include?(vowels)}

```

A string that is the concatenation of all the words. 
```ruby
words.join()
```

A string that contains exactly one of each letter contained in any word, in sorted order. So if words contains `["apple", "banana", nil, "cat"]`, the string should be `"abcelnpt"`. __Hint__: Consider using `uniq`. __Hint 2__: To use `uniq`, consider also using `chars`.
```ruby
```

## Extra Practice

Implement a linked list. Try to include the add, delete, and contains operations.
```ruby
```