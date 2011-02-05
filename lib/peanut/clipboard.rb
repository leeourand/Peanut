module Peanut
  class Clipboard
    class << self

      def copy(string)
        cmd = if RUBY_PLATFORM =~ /linux/
          "xclip -selection clipboard"
        else
          "pbcopy"
        end
        
        `echo '#{string}' | tr -d "\n" | #{cmd}`        
      end
      
      def paste
        if RUBY_PLATFORM =~ /linux/
          `xclip -selection clipboard -o`
        else
          `pbpaste`
        end
      end
    end
  end
end
