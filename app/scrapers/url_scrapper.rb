class UrlScrapper
  def initialize(url, params)
    @url = url
    @params = params
  end

  def scrape
    uri = URI(@url)
    uri.query = URI.encode_www_form(@params)

    res = Net::HTTP.get_response(uri)
    res.body
  end
end
