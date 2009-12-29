require "hi-lite/parser"
require "hi-lite/css_file"
require "hi-lite/css_embedder"

module HiLite
  class << self
    
    def hilite(code, opts = {})
      opts = {
        :syntax => "ruby",
        :line_numbers => true,
        :theme => "eiffel",
        :headers => false
      }.merge(opts)
      embed_css(parse(code, opts), opts[:theme])
    end
    
    def themes_list
      Uv.themes
    end
    
    def lang_list
      Uv.syntaxes
    end
    
    def nice_lang_list
      lang_list.inject(Hash.new) { |langs, s| langs.merge!({ s => nicer(s) }) }
    end
    
    private
    
    LANGS_REGISTER = %w(CSS HTML XML XSL YAML CSV PHP XHTML JSON IO ActionScript SSH SQL ML lighttpd ASP ASP.NET VB.NET jQuery man GreaseMonkey)
    
    def nicer(lang)
      result = lang.dup
      result.gsub!(/[_-]+/, " ")
      register = LANGS_REGISTER.map{ |s| s.downcase }
      result = result.downcase.split.map{ |s| register.include?(s) ? LANGS_REGISTER[register.index(s)] : s.capitalize }.join(" ")
      result.gsub!(/script/i, "Script")
      result.gsub!(/wiki/i, "Wiki")
      result
    end
    
    def parse(code, opts)
      Parser.parse(code, opts)
    end
    
    def embed_css(code, theme)
      css = Uv.theme_css(theme)
      css = CssFile.new(css)
      CssEmbedder.embed(code, css)
    end
    
  end
end