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
    
    private
    
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