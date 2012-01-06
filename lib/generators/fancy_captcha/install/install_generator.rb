require File.expand_path('../../utils', __FILE__)

class FancyCaptcha::InstallGenerator < Rails::Generators::Base

  source_root File.expand_path('../templates', __FILE__)

  include FancyCaptcha::Generators::Utils::InstanceMethods

  desc "Creates FancyCaptcha initializer and copy locale files to your application."

  def create_initializer
    data_fancy_captcha_rb = %Q/
FancyCaptcha.configure do |config|
  config.image_columns  = 120
  config.image_rows     = 40
  config.image_style    = "simply_blue"
  config.text_range     = ("a".."z").to_a
  config.text_length    = 5
  config.images_path    = Rails.root.join("public", "system", "captcha_images").to_s
  config.enable         = true
  config.salt           = "#{ SecureRandom.hex(20) }"
end
    /
    initializer "fancy_captcha.rb", data_fancy_captcha_rb
  end

  def create_locale
    copy_file "../../../../../config/locales/fancy_captcha.en.yml", "config/locales/fancy_captcha.en.yml"
  end

  def create_views
    filename_pattern = File.expand_path("../../../../../app/views/fancy_captcha/captcha_styles/*", __FILE__)
    Dir[filename_pattern].each do |f|
      copy_file f, "app/views/fancy_captcha/captcha_styles/#{File.basename f}"
    end
  end

  def test_rakes
    display "test generate and clear images..."
    rake("fancy_captcha:generate_images[1]")
    rake("fancy_captcha:clear_images")
  end

  def show_readme
    display "Succeed! fancy_captcha has been installed."
    readme("README")
  end
end

