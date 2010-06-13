# Enables support for SASS template reloading in rack applications.
# See http://nex-3.com/posts/88-sass-supports-rack for more details.
# Store SASS files (by default) within 'app/stylesheets'

module SassInitializer
  def self.registered(app)
    require 'sass/plugin/rack'
    Sass::Plugin.options[:template_location] = Padrino.root("app/stylesheets")
    # Sass::Plugin.options[:css_location] = Padrino.root("public/stylesheets")

    # Sass::Plugin.options[:sass_dir] = "stylesheets"
    # Sass::Plugin.options[:project_type] = :stand_alone
    # Sass::Plugin.options[:http_path] = "/"
    # Sass::Plugin.options[:css_dir] = "stylesheets"
    # Sass::Plugin.options[:images_dir] = "images"
    # Sass::Plugin.options[:output_style] = :compressed    
    
    app.use Sass::Plugin::Rack
  end
end