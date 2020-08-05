class CompileBackground
  attr_reader :url
  def initialize(location)
    image_object = UnsplashServices.new.image_by_keyword(location)
    @url = parse_url(image_object)
  end

  def parse_url(image_object)
    types = [:regular, :small, :thumb]
    keys = image_object[:urls].keys
    url = {:url => nil}
    i = 0

    keys.each do |key|
      if key = types[i]
        url[:url] = image_object[:urls][key]
      end
    end
    url
  end
end
