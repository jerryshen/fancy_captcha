module FancyCaptcha
  module Image
    mattr_reader :image_style
    @@image_style = {
      :simply_blue => {:background_color => :white, :text_fill => :darkblue, :text_font_family => :helvetica}
    }
    #image text length and image text font_size proportion
    @@font_size = {
      4 => 46,
      5 => 41,
      6 => 36,
      7 => 31,
      8 => 26,
      9 => 21,
      10 => 16
    }

    class << self
      def create(number=1, &block)
        image_style_simply_blue = @@image_style[:simply_blue]
        image_style = @@image_style[FancyCaptcha::Configuration.image_style] || image_style_simply_blue
        options = {}
        options[:background_color] = image_style[:background_color] || image_style_simply_blue[:background_color]
        options[:text_fill] = image_style[:text_fill] || image_style_simply_blue[:text_fill]
        options[:text_font_family] = image_style[:text_font_family] || image_style_simply_blue[:text_font_family]
        image_files = create_image_files(number, options, &block)
      end
    end

    private
      class << self
        def generate_image_text
          text_range = FancyCaptcha::Configuration.text_range
          text_length = FancyCaptcha::Configuration.text_length
          text_range.to_a.sort_by!{rand()}.take(text_length).join()
        end

        def generate_image_file_path(text)
          File.join(
            FancyCaptcha::Utils.image_file_dirname(),
            [
              FancyCaptcha::Utils.image_file_basename(text),
              FancyCaptcha::Utils.image_file_extname()
            ].join()
          )
        end

        def create_image_files(number, options={}, &block)
          columns = FancyCaptcha::Configuration.image_columns
          rows = FancyCaptcha::Configuration.image_rows

          image_files = []
          number.to_i.times do |n|
            canvas = Magick::ImageList.new
            canvas.new_image(columns, rows) {
              self.background_color = options[:background_color].to_s
            }
            text = Magick::Draw.new
            text.font_family = options[:text_font_family].to_s
            text.fill = options[:text_fill].to_s
            text.gravity = Magick::CenterGravity

            image_text = generate_image_text()
            text.annotate(canvas, 0,0,0,0, image_text) {
              self.pointsize = @@font_size[image_text.length]
            }
            image_file = generate_image_file_path(image_text)
            begin
              canvas.write(image_file)
            rescue
              yield(number, n+1, "failed", image_file) if block
              next
            else
              yield(number, n+1, "succeed", image_file) if block
              image_files << image_file
            ensure
              canvas.clear
            end
          end
          image_files
        end

      end
  end
end

