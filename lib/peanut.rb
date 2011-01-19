require 'yajl'

module Peanut
  
  require 'peanut/clipboard'
  require 'peanut/store'
  require 'peanut/command'

# Makes for easier testing if I/O
  def self.output(string)
    puts string
  end
end

