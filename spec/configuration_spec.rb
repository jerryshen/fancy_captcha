#encoding: utf-8
require "spec_helper"

describe FancyCaptcha::Configuration do

  it "should set a configuration" do
    FancyCaptcha::Configuration.text_length.should == 5
    FancyCaptcha.configure do |config|
      config.text_length = 6
    end
    FancyCaptcha::Configuration.text_length.should == 6
  end

  it "should define images path and create images path" do
    FancyCaptcha::Configuration.make_and_define_images_path()
    File.exist?(FancyCaptcha::Configuration.images_path_definite).should be_true
  end
end

