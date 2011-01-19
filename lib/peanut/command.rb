module Peanut
  class Command
    class << self
            
      def run(*args)
        key = args.shift
        value = args.join(' ') unless args.length == 0
        
        return help unless key
        return send key, value if is_arged_keyword?(key)
        return send key if is_keyword?(key)
        return save! key, value if key && value
        return get key
      end
      
      private
      
      def store
        @store ||= Peanut::Store.new(ENV['HOME'] + '/.peanut')
      end
      
      def list
        Peanut::output "Your peanut bucket: \n#{'-' * 20}"
        store.each_pair do |key, value|
          Peanut::output "#{key}: #{value}"
        end
      end   
      
      def help
        Peanut::output %{
            #{executable} <key> <value>      sets the "key" value to "value"
            #{executable} <key>              copies the value for "key" to the clipboard
            #{executable} rm <foo>           removes the key/value pair where the key = foo
            #{executable} <foo> v            stores your current clipboard value into foo
            #{executable} list               shows all the values that are in your peanut bucket
            #{executable} help               shows you this help document
        }.gsub(/^ {10}/, '') # murderous villain of whitespace   
      end
    
      def get(key)
        if val = store[key]
          Clipboard.copy(val)
          Peanut::output "Copied '#{val}' to the clipboard!"
        else
          Peanut::output "No value stored with key '#{key}'"
        end
      end
    
      def save!(key, val)
        val = Clipboard.paste if val == 'v'
        store[key.to_sym] = val
        store.save!
        Peanut::output "Saved '#{val}' as '#{key}'"
      end
    
      def executable
        @executable ||= $0.split('/').pop
      end
    
      def rm(key)
        store[key] = nil
        store.save!
        Peanut::output "Deleted the value with the key '#{key}'"
      end
    
      def is_keyword?(word)
        ['rm', 'list', 'help'].include? word
      end
    
      def is_arged_keyword?(word)
        ['rm'].include? word
      end
    end
  end
end