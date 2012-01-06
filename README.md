#FancyCaptcha

FancyCaptcha is a simple captcha plugin for Rails 3

* https://github.com/jerryshen/fancy_captcha

##Supported versions

* Ruby 1.8.7, 1.9.2, 1.9.3

* Rails 3.0.x, 3.1.x

* ImageMagick should be installed on your machine to use this plugin.


##Installation

In your app's `Gemfile`, add:

    gem "fancy_captcha", "~> 0.1.0"

Then run:

    bundle
    rails generate fancy_captcha:install

If you want to modify default captcha images storage location, edit your `config/initializers/fancy_captcha.rb`

Then run:

    bundle exec rake fancy_captcha:generate_images[100]


##Base Usage

###View helper

In the view file within the form tags add this code

    <%= display_fancy_captcha %>

and in the controller's action authenticate it as

    if fancy_captcha_valid?(params[:fancy_captcha])
      flash[:notice] = "captcha did match."
    else
      flash[:notice] = "captcha did not match."
    end

###FormBuilder helper

In the model class add this code

    class User < ActiveRecord::Basse
      apply_fancy_captcha
    end

and in the view file within the form tags write this code

    <%= form_for @user do |form| -%>
      ...
      <%= form.fancy_captcha %>
      ...
    <% end -%>


##Usage your custom captcha area template

first, copy and modify your custom captcha area template

    cd app/views/fancy_captcha/captcha_styles/
    cp _default.html.erb _mycaptcha.html.erb

and then in the view file your the use of

    <%= display_fancy_captcha(:template => :mycaptcha) %>


##Options & Examples

###Helper Options, View helper and FormBuilder helper

* *template* - use your custom template

* *label_text* - custom label text

* *key_id* - custom captcha hidden input key id

* *key_name* - custom captcha hidden input key name

* *field_name* - custom captcha input field name

* *img_id* - custom captcha img id

* *change_text* - custom change text

###Examples

    <%= display_fancy_captcha(:img_id => :captcha, :label_text => "captcha", :field_name => :captcha %>


##I18n supported
