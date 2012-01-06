Rails.application.routes.draw do
  match "captcha_images/change" => "fancy_captcha/captcha_images#change",
          :as => :change_captcha_images

  match "captcha_images/:key" => "fancy_captcha/captcha_images#show",
          :as => :show_captcha_image,
          :constraints => { :key => /[A-Za-z0-9]{32,40}/ }
end

