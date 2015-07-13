#!/usr/bin/env ruby

# run on sections change: fswatch -o sections -o css -o templates | xargs -n1 ./generate.rb

require 'erb'
require 'ostruct'
require 'json'

require_relative 'templates/helpers'

class Template < OpenStruct
  include TemplateHelpers

  def render(contents)
    ERB.new(contents).result(binding)
  end
end

class Section < Struct.new(:group, :name, :title, :contents); end

class Page
  def initialize(template, section_config)
    @template = template
    @section_config = section_config
  end  

  def render
    sections = []
    @section_config.each do |section_group, section_defs|
      section_defs.each do |section_name, section_title|
        sections << Section.new(section_group, section_name, section_title, section_contents(section_name))
      end
    end  

    template_page = Template.new({"sections" => sections})
    File.open(result_file, 'w') do |f|
      f.write(template_page.render(template_contents))
    end  
  end

  def section_contents(name)
    section_template = File.read(File.expand_path("#{name}.html", './sections'))
    Template.new.render(section_template)
  end  

  def template_contents
    File.read(File.expand_path("#{@template}.html.erb", './templates'))
  end

  def result_file
    File.expand_path("#{@template}.html", '.')
  end
end

section_config = JSON.load(File.read('sections.json'))

site = Page.new('index', section_config)
site.render