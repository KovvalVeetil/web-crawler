# app/services/crawler_service.rb
require 'pry'
require 'nokogiri'
require 'httparty'

class CrawlerService
  def initialize
    @products = []
  end

  def crawl
    crawl_bestbuy_canada
    crawl_newegg_canada
    compare_products
    @products
  end

  private

  def crawl_bestbuy_canada
    url = 'https://www.bestbuy.ca/en-ca/search?search=electronics'
    response = HTTParty.get(url, headers: { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36" })
    parse_bestbuy(response.body)
    rescue => e
    puts "Error fetching or parsing Best Buy Canada: #{e.message}"
  end

  def crawl_newegg_canada
    url = 'https://www.newegg.ca/p/pl?d=electronics'
    response = HTTParty.get(url, headers: { "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36" })
    parse_newegg(response.body)
    rescue => e
    puts "Error fetching or parsing Newegg Canada: #{e.message}"
  end

  def parse_bestbuy(html)
    doc = Nokogiri::HTML(html)

  
    # Assuming you have identified the correct CSS selectors for products
    doc.css('div.product-item').each do |item|
      # Adjust selectors based on actual HTML structure
      name = item.css('div.product-name').text.strip
      price = item.css('span.product-price').text.strip.gsub('$', '').gsub(',', '').to_f
      url = item.css('a.product-link').first['href']
      url = "https://www.bestbuy.ca#{url}" if url
  
      next if name.empty? || price.zero?
  
      @products << Product.create(name: name, price: price, website: 'Best Buy Canada', url: url)
    end
  end
  

  def parse_newegg(html)
    doc = Nokogiri::HTML(html)
    doc.css('.item-cell').each do |item|
      name = item.css('.item-title').text.strip
      price = item.css('.price-current').text.strip.gsub('$', '').gsub(',', '').to_f
      url = item.css('.item-title').first['href']

      next if name.empty? || price.zero?

      @products << Product.create(name: name, price: price, website: 'Newegg Canada', url: url)
    end
  end

  def compare_products
    bestbuy_products = @products.select { |p| p.website == 'Best Buy Canada' }
    newegg_products = @products.select { |p| p.website == 'Newegg Canada' }

    bestbuy_products.each do |bb_product|
      newegg_products.each do |ne_product|
        if bb_product.name.downcase.include?(ne_product.name.downcase) || ne_product.name.downcase.include?(bb_product.name.downcase)
          puts "Comparison: #{bb_product.name}"
          puts "Best Buy Canada Price: $#{bb_product.price} - URL: #{bb_product.url}"
          puts "Newegg Canada Price: $#{ne_product.price} - URL: #{ne_product.url}"
          puts "-" * 40
        end
      end
    end
  end
end
