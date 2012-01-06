module FancyCaptcha
  module Configuration

    mattr_accessor  :image_columns,
                    :image_rows,
                    :image_style,
                    :text_range,
                    :text_length,
                    :images_path,
                    :enable,
                    :salt
    mattr_reader    :images_path_definite

    class << self

      def configure
        yield self
        # make inage files path and defined @@images_path_definite
        make_and_define_images_path()
        # reload all image files key
        FancyCaptcha::Utils.reload_image_files_paths()
      end

      def reset_config
        configure do |config|
          config.image_columns  = default_image_columns()
          config.image_rows     = default_image_rows()
          config.image_style    = FancyCaptcha::Image.image_style.keys.first
          config.text_range     = default_text_range()
          config.text_length    = default_text_length()
          config.images_path    = default_images_path()
          config.enable         = true
          config.salt           = SecureRandom.hex(10)
        end
        make_and_define_images_path()
      end
      alias_method :init_config, :reset_config

      def disable?
        !@@enable
      end

      #image columns setting
      def default_image_columns
        120
      end
      def image_columns
        image_columns = @@image_columns.to_i.blank? ? default_image_columns() : @@image_columns
      end

      #image rows setting
      def default_image_rows
        40
      end
      def image_rows
        image_rows = @@image_rows.to_i.blank? ? default_image_rows() : @@image_rows
      end

      #image style setting
      def default_image_style

      end

      #image text range setting
      def default_text_range
        ('a'..'z').to_a + (0..9).to_a
      end
      def text_range
        text_range = @@text_range.to_a.blank? ? default_text_range() : @@text_range
      end

      #image text length setting
      def default_text_length
        5
      end
      def text_length
        text_length = @@text_length.to_i.blank? ? default_text_length() : @@text_length
        if 4 < text_length or text_length < 10
          text_length
        else
          default_text_length()
        end
      end

      #images path setting
      def default_images_path
        File.join(Dir::tmpdir, 'captcha_images')
      end
      def images_path
        images_path = @@images_path.to_s.blank? ? default_images_path() : @@images_path
      end

      #images path make and define
      def make_and_define_images_path
        images_path = images_path()
        begin
          FileUtils.mkdir_p images_path
        rescue
          raise FancyCaptcha::MakeImagePathError
        else
          @@images_path_definite = images_path
        end
      end
    end
  end
end

