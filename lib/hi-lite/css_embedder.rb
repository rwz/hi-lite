require "rubygems"
require "nokogiri"

module HiLite
  class CssEmbedder
    class << self
      def embed(code, css)
        code = Nokogiri::HTML.fragment(code)
        css.each_selector do |selector, style|
          code.css(selector).each do |node|
            node["style"] = ((node["style"] || "").split(";") + style.split(";")).join(";")
          end
        end
        remove_class(code)
        code.to_s
      end
      
      private
      
      def remove_class(node)
        node.remove_attribute("class") if node["style"]
        node.children.each { |c| remove_class(c) }
      end
    end
  end
end