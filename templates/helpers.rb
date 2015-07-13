require_relative 'helpers/circled_title'

module TemplateHelpers
  def circled_title(number, title)
    CircledTitle.new(number, title).render
  end
end    