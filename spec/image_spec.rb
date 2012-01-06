#encoding: utf-8
require "spec_helper"

describe FancyCaptcha::Image do

  it "should create a image" do
    FancyCaptcha::Image.create().should be_true
  end
end

