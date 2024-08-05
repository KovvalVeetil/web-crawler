require 'nokogiri'
require 'open-uri'
require 'json'
require 'pry'

class ScrapeBestBuy
  BASE_URL = 'https://www.bestbuy.ca/'

  def initialize
    @url = BASE_URL
  end

  def call
    begin
      puts "Fetching URL: #{@url}"
      html = URI.open(@url).read
      doc = Nokogiri::HTML(html)

      products = []

      doc.css('div.product-item').each do |item|
        name = item.css('div.product-name').text.strip
        price = item.css('span.product-price').text.strip.gsub('$', '').gsub(',', '').to_f
        url = item.css('a.product-link').first['href']
        url = "https://www.bestbuy.ca#{url}" if url

        products << { name: name, price: price, url: url }
      end

      puts "Products found:"
      products.each do |product|
        puts "#{product[:name]} - $#{product[:price]} (Best Buy)"
        puts "URL: #{product[:url]}"
      end

      products

    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end
end

# To run the script
ScrapeBestBuy.new.call
