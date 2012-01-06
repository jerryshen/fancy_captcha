class FancyCaptcha::CaptchaImagesController < ApplicationController

  respond_to :html, :js, :json

  def show
    @image_file_path = read_image_file_path(params[:key])
    respond_to do |format|
      format.html {
        send_file(@image_file_path, :type => 'image/jpeg', :disposition => 'inline', :filename => 'fancy_captcha.jpg')
      }
      format.json { render :json => {:image_file_path => @image_file_path} }
    end
  end

  def change
    @img_id = params[:img_id] || FancyCaptcha::DEFAULTVALUE[:img_id]
    @key_id = params[:key_id] || FancyCaptcha::DEFAULTVALUE[:key_id]
    @key = choice_image_file_path_and_write_session_cache()
    @img_src = show_captcha_image_path(@key)

    respond_to do |format|
      format.js
      format.json { render :json => {@img_id => @img_src, @key_id => @key} }
    end
  end

end

