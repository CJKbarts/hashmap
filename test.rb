require 'pry-byebug'
require_relative 'lib/hashmap'
require_relative 'lib/linked_list'
require_relative 'lib/node'

hashmap = HashMap.new
hashmap.set("Cornelius", 1)
hashmap.set("Bartels", 2)
hashmap.set("Jacob", 3)

puts hashmap
