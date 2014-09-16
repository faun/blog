
###
# Blog settings
###

Time.zone = 'Bangkok'

###
# Markdown
###

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

# ###
# # Code highlighting
# ###

activate :syntax, :line_numbers => true

activate :blog do |blog|

  # blog.permalink = ':year/:month/:day/:title.html'
  # blog.sources = ':year-:month-:day-:title.html'
  # blog.taglink = 'tags/:tag.html'

  blog.layout = 'layouts/post.html.haml'

  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = ':year.html'
  # blog.month_link = ':year/:month.html'
  # blog.day_link = ':year/:month/:day.html'
  blog.default_extension = '.md'

  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = 'page/:num'
end

###
# RSS Feed
###

page '/feed.xml', :layout => false

###
# Compass
###
# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page '/path/to/file.html', :layout => false
#
# With alternative layout
# page '/path/to/file.html', :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page '/admin/*'
# end

# Proxy (fake) files
# page '/this-page-has-no-template.html', :proxy => '/template-file.html' do
#   @which_fake_page = 'Rendering a fake page with a variable'
# end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     'Helping'
#   end
# end
require 'ostruct'
require 'yaml'

class SiteSettings < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    settings = OpenStruct.new YAML::load File.read '_config.yml'

    app.set :site, settings
    super
  end
end

::Middleman::Extensions.register(:site_settings, SiteSettings)
activate :site_settings

set :file_watcher_ignore, [
    /^\.idea\//,
    /^\.bundle\//,
    /^\.sass-cache\//,
    /^\.git\//,
    /^\.gitignore$/,
    /\.DS_Store/,
    /^build\//,
    /^\.rbenv-.*$/,
    /^Gemfile$/,
    /^Gemfile\.lock$/,
    /~$/,
    /(^|\/)\.?#/
]
activate :livereload

set :haml, { :ugly => true, :format => :html5 }

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  # activate :cache_buster

  # Use relative URLs
  # activate :relative_assets

  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require 'middleman-smusher'
  # activate :smusher

  # Or use a different image path
  # set :http_path, '/Content/images/'
end

require 'rack/offline'

ready do
  all_pages = sitemap.resources.map{|r| r.destination_path }
  offline = Rack::Offline.configure do
    cache 'http://code.jquery.com/jquery.min.js'
    cache 'http://html5shim.googlecode.com/svn/trunk/html5.js'
    fallback '/' =>  '/offline.html'
    network 'http://www.google-analytics.com/ga.js'
    network 'http://www.google-analytics.com/__utm.gif'
    network 'http://code.jquery.com/jquery-2.1.1.min.map'
    all_pages.each {|page| cache page }
  end

  map('/offline.appcache') { run offline }
  endpoint 'offline.appcache', :path => '/offline.appcache'
end

