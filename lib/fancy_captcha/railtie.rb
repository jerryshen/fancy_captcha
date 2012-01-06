require 'fancy_captcha/common_methods'
require 'fancy_captcha/action_controller_extension'
require 'fancy_captcha/action_view_extension'
require 'fancy_captcha/active_record_extension'

module FancyCaptcha
  class Railtie < ::Rails::Railtie
    initializer 'fancy_captcha' do |app|
      ActiveSupport.on_load :action_controller do
        ActionController::Base.send :include, FancyCaptcha::ActionControllerExtension
      end

      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, FancyCaptcha::ActionViewExtension::Base
        ActionView::Helpers::FormBuilder.send :include,
                                FancyCaptcha::ActionViewExtension::Helpers::FormBuilder
      end

      ActiveSupport.on_load :active_record do
        include FancyCaptcha::ActiveRecordExtension
      end
    end
  end
end

