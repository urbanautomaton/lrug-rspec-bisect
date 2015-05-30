#!/usr/bin/env ruby

require 'bundler'
Bundler.setup
require 'colored'

def example_set(count, range)
  (1..count).map do |n|
    if range.member?(n)
      example
    else
      "  "
    end
  end.join
end

def example
  " █"
end

prefix = "         "

puts
puts
puts
puts
puts [prefix, example_set(10, (1..10)).green, example.red].join
puts [prefix, example_set(10, (1..5)).green, example.green].join
puts [prefix, example_set(10, (6..10)).green, example.red].join
puts [prefix, example_set(10, (6..8)).green, example.red].join
puts [prefix, example_set(10, (6..7)).green, example.green].join
puts [prefix, example_set(10, (8..8)).green, example.red].join
puts
puts
puts
puts
puts
puts [prefix, example_set(20, (1..20)).green].join
puts
puts
puts
puts
puts [prefix, example_set(15, (1..15)).green, example.red, example_set(4, (1..4)).green].join 
puts
puts
puts
puts
3.times do
  puts [prefix, example_set(20, (1..20)).green].join
end
puts [prefix, example_set(15, (1..15)).green, example.red, example_set(4, (1..4)).green].join 
2.times do
  puts [prefix, example_set(20, (1..20)).green].join
end
puts
puts
puts
puts

