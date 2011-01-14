module Peanut
  class Store

    attr_accessor :store, :file

    def initialize(file)
      self.file = file
      
      init_file unless File.exists?(file)
      self.store = Yajl::Parser.parse(File.new(file, 'r'))
    end

    def to_json
      Yajl::Encoder.encode(store)
    end

    def []=(key, val)
      self.store[key] = val
      self.store.delete(key) if val.nil?
      return val
    end

    def [](key)
      return store[key]
    end
    
    def save!
      File.open(file, 'w') { |f| f.write(to_json) }
    end
    
    def each_pair
      store.each do |key, val|
        yield key, val
      end
      
      if store.empty?
        yield "Bucket", "empty"
      end
    end
    
    private
    
    def init_file
      File.open(file, 'w') { |f| f.write "{}" }
    end
  end
end