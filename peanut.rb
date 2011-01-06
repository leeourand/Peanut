#!/usr/bin/ruby

require 'rubygems'
require 'yajl'

module Peanut
  
  def self.storage
    @storage ||= Peanut::Storage.new
  end
  
  class Command
    class << self
      def storage
        Peanut.storage
      end
      
      def run(*args)
        cmd = args[0]
        main = args[1]
        minor = args[2]
        
        return help unless cmd
        delegate(cmd, main, minor)        
      end
      
      def delegate(cmd, main, minor)
        if cmd == "add"
          storage.store.merge!({main.to_sym => minor}) if main && minor
        elsif cmd == "del"
          storage.store.delete(main) if main
        elsif cmd == "get"
          Clipboard.copy_to_clipboard(storage.store[main])
        elsif cmd == "list"
          storage.store.each do |key, value|
            puts "#{key}: #{value}"
          end
        end
          storage.writeback
      end
      
      def help
        txt = %{
          - peanut: help ---------------------------------------------
          
          peanut help                 show this help overview
          peanut add <key> <value>    adds the key/value pair to your bucket
          peanut list                 shows everything currently in your bucket
          peanut delete <key>         removes the key/value pair where key matches
          peanut get <key>            copies the value of key to your clipboard
        }.gsub(/^ {10}/, '') # murderous villian of whitespace
        
        puts txt
      end      
    end
  end
  
  class Storage
    
    JSON_FILE = "#{ENV['HOME']}/.peanut"
    
    attr_accessor :store
    
    def initialize
      @store = {}
      explode_json(json_file)
    end

    def json_file
      JSON_FILE
    end

    def to_json(hash)
      Yajl::Encoder.encode(hash)
    end
    
    def explode_json(file)
      init_json unless File.exists?(file)
      
      json = File.new(file, 'r')
      @store = Yajl::Parser.parse(json)
    end
    
    def init_json
      File.open(json_file, 'w') { |f| f.write "{}"}
      writeback
    end

    def writeback
      File.open(json_file, 'w') { |f| f.write(to_json(@store)) }
    end
  end
  
  class Clipboard
    class << self

      def copy_to_clipboard(string)
        cmd = 
        if RUBY_PLATFORM =~ /linux/
          "xclip -selection clipboard"
        else
          "pbcopy"
        end
        
        `echo #{string} | tr -d "\n" | #{cmd}`        
      end
    end
  end
  
end

Peanut::Command.run(*ARGV)
