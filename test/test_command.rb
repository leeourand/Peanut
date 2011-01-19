require 'helper'

# Dont Mind this
# Just a little ghetto monkey patching
# It lets us grab the STD I/O, and test it
module Peanut
  
  attr_accessor :outputted_string
    def self.output(string)
      @outputted_string << string
    end
  
    def self.before_output
      @outputted_string = ""
    end
  
    def self.captured_output
      @outputted_string
    end
end

class TestCommand < Test::Unit::TestCase
  
  def setup
    peanut_json "test"
  end
  
  def command(cmd)
    cmd = cmd.split(' ') if cmd
    Peanut::before_output
    Peanut::Command.run(*cmd)
    Peanut::captured_output
  end
  
  def test_adding_entry
    assert_equal "Saved 'testing' as 'test'", command("test testing")
  end
  
  def test_removing_entry
    assert_equal "Deleted the value with the key 'test'", command("rm test")
  end
  
  def test_list
    assert_equal "Your peanut bucket: \n--------------------test: testingtest: testing", command("list")
  end
  
end
  