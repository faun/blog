# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'middleman' do
  watch(%r{^config\.(rb|ru)})
  watch(%r{^data/.*})
  watch(%r{^source/.*})
  watch(%r{_config\.(yml)})
end

guard 'livereload' do
  watch(%r{_config\.(yml)})
  watch(%r{config\.(rb|ru)})
  watch(%r{data/.+\.(json|yml)})
  watch(%r{source/.+\.(css|js|html)})
  watch(%r{source/.+\.(erb|haml|slim)$})
end
