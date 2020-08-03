class UnsplashServices
  def initialize
    conn = Faraday.new(url: "https://api.unsplash.com/")
  end

  def image_by_keyword(keyword)
    response = conn.get("search/photos??page=1&query=office&client_id=#{ENV['UNSPLASH_KEY']}")
    pased = JSON.parse(response.body, symbolize_names: true)
    require "pry";binding.pry
  end
end
