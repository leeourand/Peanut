require 'test/unit'

begin
  require 'rubygems'
  require 'redgreen' # We'd like to see pretty pass/fails!
rescue LoadError
end

require 'mocha'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'peanut'

def peanut_json(name)
  #Peanut::Store.any_instance.stubs(:json_file).
  #returns("test/examples/#{name}.json")
  Peanut.stubs(:storage).returns(Peanut::Store.new("examples/#{name}.json"))
end