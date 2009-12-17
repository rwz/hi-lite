module HiLite
  class CssFile

    def initialize(csstext)
      @css = {}
      csstext.scan(/([.#:]?[-_\w]+(?:\s+[.#:]?[-_\w]+)?)\s?\{([^{}]*)\}/im).each do |rule|
        selector = rule.first
        selector.strip!
        style = rule.last
        style.strip!
        style.gsub!(/\s+/, ' ')
        style.gsub!(/([:;])\s+/, '\1')
        style = style.split(';').join(';')
        @css.merge!({ selector => style }) if style != ""
      end
    end
    
    def selectors
      @css.keys
    end
    
    def styles
      @css.values
    end
    
    def each_selector
      @css.each do |k,v|
        yield k, v
      end
    end
    
    def to_s
      @css.map { |k,v| "#{k}{#{v}}" }.join("\n")
    end

  end
end