require 'helper'

# Dont Mind this
# Just a little ghetto monkey patching
# It lets us grab the STD I/O, and test it
class Object
  class << self
    attr_accessor :output
    def puts(s)
      @output = s
    end
  end
end

class TestCommand < Test::Unit::TestCase
  
  def setup
    peanut_json "test"
  end
  
  def command(cmd)
    cmd = cmd.split(' ') if cmd
    Object.puts Peanut::Command.run(*cmd) 
  end
  
  def test_adding_entry
    assert_equal "Saved 'testing' as 'test'", command("test testing")
  end
  
end
  