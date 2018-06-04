require 'net/http'
require 'uri'
require 'json'

class HomeController < ApplicationController
  def index
  end

  def search
    keyword = params[:keyword]

    url = URI.parse(URI.escape("https://www.googleapis.com/books/v1/volumes?q=#{keyword}"))
    res = Net::HTTP.start(url.host, url.port, use_ssl: true){|http|
      http.get(url.path + "?" + url.query);
    }
    obj = JSON.parse(res.body)
    binding.pry
  end
end
