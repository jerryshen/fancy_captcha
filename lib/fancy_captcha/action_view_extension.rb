module FancyCaptcha
  module ActionViewExtension
    module Base
      extend ActiveSupport::Concern
      included do
        include FancyCaptcha::CommonMethods
      end
      module ClassMethods
      end
      module InstanceMethods
        def display_fancy_captcha(options={})
          return "" if FancyCaptcha::Configuration.disable?
          options[:key] = choice_image_file_path_and_write_session_cache

          options[:field_name] ||= FancyCaptcha::DEFAULTVALUE[:field_name]
          options[:key_name] ||= FancyCaptcha::DEFAULTVALUE[:key_name]
          options[:key_id] ||= FancyCaptcha::DEFAULTVALUE[:key_id]
          options[:img_id] ||= FancyCaptcha::DEFAULTVALUE[:img_id]

          options[:img_src] = show_captcha_image_path(options[:key])
          options[:template] ||= FancyCaptcha::DEFAULTVALUE[:template]
          options[:label_text] ||= I18n.t('fancy_captcha.label')
          options[:change_text] ||= I18n.t('fancy_captcha.change')
          options[:change_url] = change_captcha_images_path(:img_id => options[:img_id], :key_id => options[:key_id])
          render "fancy_captcha/captcha_styles/#{options[:template].to_s}", :captcha => options
        end
      end
    end

    module Helpers
      module FormBuilder
        extend ActiveSupport::Concern
        included do
          include FancyCaptcha::CommonMethods
        end
        module ClassMethods
        end
        module InstanceMethods
          def fancy_captcha(options={})
            return "" unless (@object.fancy_captcha_key rescue nil)
            options[:object_name] = @object_name.to_s
            options[:key] = @object.fancy_captcha_key

            options[:field_name] = object_field_name options[:object_name], FancyCaptcha::DEFAULTVALUE[:field_name]
            options[:key_name] = object_field_name options[:object_name], FancyCaptcha::DEFAULTVALUE[:key_name]
            options[:key_id] = object_field_id options[:object_name], FancyCaptcha::DEFAULTVALUE[:key_id]
            options[:img_id] = object_field_id options[:object_name], FancyCaptcha::DEFAULTVALUE[:img_id]

            @template.display_fancy_captcha(options)
          end
        end
      end
    end
  end
end

