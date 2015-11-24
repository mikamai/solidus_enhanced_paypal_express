guard 'livereload' do
  extensions = {
    css: :css,
    scss: :css,
    sass: :css,
    js: :js,
    coffee: :js,
    html: :html,
    png: :png,
    gif: :gif,
    jpg: :jpg,
    jpeg: :jpeg,
    # less: :less, # uncomment if you want LESS stylesheets done in browser
  }

  # file types LiveReload may optimize refresh for
  compiled_exts = extensions.values.uniq
  watch(%r{public/.+\.(#{compiled_exts * '|'})})

  extensions.each do |ext, type|
    watch(%r{
          (?:app|vendor)
          (?:/assets/\w+/(?<path>[^.]+) # path+base without extension
           (?<ext>\.#{ext})) # matching extension (must be first encountered)
          (?:\.\w+|$) # other extensions
          }x) do |m|
      path = m[1]
      "/assets/#{path}.#{type}"
    end
  end

  # file needing a full reload of the page anyway
  watch(%r{app/views/.+$})
  watch(%r{app/controllers/.+$})
  watch('config/routes.rb')
end

guard 'bundler' do
  watch('Gemfile')
end

guard 'pow' do
  watch('.powrc')
  watch('.powenv')
  watch('.ruby-version')
  watch('Gemfile.lock')
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/environments/development.rb')
  watch(%r{^config/initializers/.*\.rb$})
end
