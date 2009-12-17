$: << File.dirname(__FILE__)
require "uv_ext"

module HiLite
  class Parser
    class << self
      def parse(code, opts)
        Uv.parse(code, "xhtml", opts[:syntax], opts[:line_numbers], opts[:theme], opts[:headers])
      end  
    end
  end
end