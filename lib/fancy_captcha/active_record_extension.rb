module FancyCaptcha
  module ActiveRecordExtension
    extend ActiveSupport::Concern
    included do
      include FancyCaptcha::CommonMethods
      extend ClassMethods
    end
    module ClassMethods
      def apply_fancy_captcha
        attr_accessor :fancy_captcha, :fancy_captcha_key

        after_initialize do
          after_initialize if fancy_captcha_need_valid?
        end

        validate :valid_fancy_captcha, :if => :fancy_captcha_need_valid?

        include FancyCaptcha::ActiveRecordExtension::InstanceMethods
      end
    end
    module InstanceMethods
      def after_initialize
        self.fancy_captcha_key ||= choice_image_file_path_and_write_cache
      end

      def valid_fancy_captcha
        unless FancyCaptcha::Utils.captcha_value_valid?(fancy_captcha, read_captcha_digested())
          errors.add(:fancy_captcha, I18n.t('fancy_captcha.message'))
        end
      end

      def fancy_captcha_need_valid?
        !FancyCaptcha::Configuration.disable? and !Rails.env.test?
      end

      private
        def choice_image_file_path_and_write_cache
          image_file_path, captcha_digested, key =
                    FancyCaptcha::Utils.choice_image_file_path_and_generate_captcha_digested_key
          Rails.cache.write(key, [image_file_path, captcha_digested])
          key
        end

        def read_captcha_digested
          Rails.cache.read(self.fancy_captcha_key)[1] rescue ""
        end

    end
  end
end

