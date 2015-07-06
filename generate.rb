#!/usr/bin/env ruby

# run on sections change: fswatch -o sections -o css -o templates | xargs -n1 ./generate.rb

require 'erb'
require 'ostruct'

class Template < OpenStruct
  def render(contents)
    ERB.new(contents).result(binding)
  end
end

class Page
  def initialize(template, sections)
    @template = template
    @sections = sections
  end  

  def render
    sections_map = Hash[*@sections.map(&:to_sym).zip(section_contents).flatten]

    template_page = Template.new(sections_map)
    File.open(result_file, 'w') do |f|
      f.write(template_page.render(template_contents))
    end  
  end

  def section_contents
    @sections.map do |s|
      File.read(File.expand_path("#{s}.html", './sections'))
    end  
  end  

  def template_contents
    File.read(File.expand_path("#{@template}.html.erb", './templates'))
  end

  def result_file
    File.expand_path("#{@template}.html", '.')
  end
end

site = Page.new('index', ['introduction', 'prepare', 'install_bosh_lite', 'install_bosh_cli', 'deploy', 'create_release'])
site.render
puts 'New version generated!'