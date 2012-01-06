require "active_support/concern"
require "active_support/core_ext/object"
require "active_support/core_ext/class/attribute_accessors"
require "active_support/core_ext/module/attribute_accessors"
require "securerandom"
require "RMagick"
include Magick
require "tmpdir"
require "fileutils"
require "digest/md5"
require "find"

require 'fancy_captcha/errors'
require 'fancy_captcha/version'
require 'fancy_captcha/configuration'
require 'fancy_captcha/utils'
require 'fancy_captcha/image'

require "rails"
require "fancy_captcha/engine"
require "fancy_captcha/railtie"

module FancyCaptcha
  DEFAULTVALUE = {
    :field_name => :fancy_captcha,
    :key_name => :fancy_captcha_key,
    :key_id => :fancy_captcha_key,
    :img_id => :fancy_captcha_img,
    :template => 'default'
  }
  class << self
    def configure(&block)
      FancyCaptcha::Configuration.configure(&block)
    end
  end
  # init configuration
  FancyCaptcha::Configuration.init_config()
end

