require File.expand_path('../../utils', __FILE__)

class FancyCaptcha::UninstallGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  include FancyCaptcha::Generators::Utils::InstanceMethods

  desc "Remove FancyCaptcha initializer and remove locale files from your application."

  def clear_images
    rake("fancy_captcha:clear_images")
  end

  def destroy_initializer
    remove_file "config/initializers/fancy_captcha.rb"
  end

  def destroy_locale
    remove_file "config/locales/fancy_captcha.en.yml"
  end

  def destroy_views
    remove_file "app/views/fancy_captcha/captcha_styles"
  end

  def show_readme
    display "Done! fancy_captcha has been uninstalled."
    readme("README")
  end
end

