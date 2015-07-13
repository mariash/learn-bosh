class CircledTitle < Struct.new(:number, :title)
  def render
    template = File.read(File.expand_path("../circled_title.html.erb", __FILE__))
    ERB.new(template).result(binding)
  end
end  