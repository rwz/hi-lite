require "rubygems"
require "uv"

module Uv
  class << self
    
    def theme_css(theme_name)
      raise "Could not find theme" unless themes.include? theme_name
      filename = File.join(find_uv_path, "render", "xhtml", "files", "css", "#{theme_name}.css")
      File.read(filename)
    end
    
    private
    
    def find_uv_path
      uv_path = []
      Gem.path.each do |gem_path|
        uv_path += Dir.glob(File.join(gem_path, "gems", "*")).grep(/ultraviolet/)
      end
      uv_path.uniq!
      raise "Could not find ultraviolet gem path" if uv_path.empty?
      uv_path.first
    end
    
  end
end