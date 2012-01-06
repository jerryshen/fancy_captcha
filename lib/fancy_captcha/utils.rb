module FancyCaptcha
  module Utils

    mattr_reader :image_files_paths, :image_files_paths_choice_size
    @@image_files_paths = []
    @@image_files_paths_choice_size = @@image_files_paths.size

    class << self

      def generate_image_files(number=1, &block)
        FancyCaptcha::Image.create(number, &block)
      end

      def clear_image_files
        FileUtils.rm_r Dir[File.join(image_file_dirname(), "**", "*")]
      end

      def reload_image_files_paths
        @@image_files_paths.clear
        reset_image_files_paths()
      end
      alias_method :init_image_files_paths, :reload_image_files_paths


      def choice_image_file_path_and_generate_captcha_digested_key
        image_file_path = random_choice_image_file_path
        captcha_digested = get_captcha_digested(image_file_path)
        key = hexdigest_text([Time.now.to_i, SecureRandom.hex(10)].join())
        [image_file_path, captcha_digested, key]
      end

      def captcha_value_valid?(captcha_value, captcha_digested)
        image_file_basename_suffix(captcha_value) == captcha_digested
      end

    end

    private
      class << self
        def hexdigest_text(text)
          Digest::MD5.hexdigest([text.to_s.downcase, FancyCaptcha::Configuration.salt].join())
        end

        def image_file_dirname
          FancyCaptcha::Configuration.images_path_definite
        end

        def image_file_basename_prefix
#          ("a".."z").to_a.sort_by!{rand()}.take(8).join()
          SecureRandom.hex(4)
        end

        def image_file_basename_suffix(text)
          hexdigest_text(text)
        end

        def image_file_basename(text)
          [image_file_basename_prefix, image_file_basename_suffix(text)].join()
        end

        def image_file_extname
          ".gif"
        end

        # if image file path empty, then auto generating 3 image file.
        def reset_image_files_paths
          if @@image_files_paths.blank? or @@image_files_paths_choice_size == 0
            n = 0
            while true
              @@image_files_paths = Dir[File.join(image_file_dirname(), ["[a-z0-9]*", image_file_extname()].join())]
              break unless self.image_files_paths.blank?
              generate_image_files(3)
              raise InitImageFilesKeyError if n >= 3
              n += 1
            end
            @@image_files_paths.sort_by!{rand()}
            @@image_files_paths_choice_size = @@image_files_paths.size
          end
        end

        def random_choice_image_file_path
          reset_image_files_paths()
          @@image_files_paths_choice_size -= 1
          @@image_files_paths[@@image_files_paths_choice_size]
        end

        def get_captcha_digested(image_file_path)
          image_file_basename = File.basename(image_file_path, image_file_extname())
          image_file_basename[-32..-1]
        end
      end
  end
end

