class UnsplashServices
  def initialize
    @conn = Faraday.new(url: "https://api.unsplash.com/")
  end

  def image_by_keyword(keyword)
    response = @conn.get("photos/random?&content_filter=high&query=#{keyword}&client_id=#{ENV['UNSPLASH_KEY']}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
