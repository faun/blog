require 'rspec'
require 'capybara/rspec'
require 'rack'

ENV['RACK_ENV'] ||= 'test'

# Build the Hugo site before running tests
RSpec.configure do |config|
  config.order = 'random'
  config.include Capybara::DSL

  config.before(:suite) do
    system('rm -rf build && hugo --destination build') || raise('Hugo build failed')
  end

  # Serve the Hugo build directory as a static Rack app
  Capybara.app = Rack::Builder.new do
    use Rack::Static, urls: [''], root: 'build', index: 'index.html'
    run ->(env) {
      # Try serving 404.html for missing pages
      path = File.join('build', env['PATH_INFO'])
      if File.exist?(path) || File.exist?("#{path}/index.html") || File.exist?("#{path}index.html")
        [404, {}, ['Not Found']]
      else
        body = File.exist?('build/404.html') ? File.read('build/404.html') : 'Not Found'
        [404, { 'content-type' => 'text/html' }, [body]]
      end
    }
  end
end
