require 'nokogiri'
require 'open-uri'
require 'benchmark'

def parse_bestbuy(html)
  puts "Parsing HTML..."
  doc = Nokogiri::HTML(html)
  products = []

  doc.css('div.product-item').each do |item|
    name = item.css('div.product-name').text.strip
    price = item.css('span.product-price').text.strip.gsub('$', '').gsub(',', '').to_f
    url = item.css('a.product-link').first['href']
    url = "https://www.bestbuy.ca#{url}" if url

    puts "Name: #{name}"
    puts "Price: #{price}"
    puts "URL: #{url}"
    puts "-" * 30

    next if name.empty? || price.zero?

    products << { name: name, price: price, website: 'Best Buy Canada', url: url }
  end

  puts "Finished parsing."
  products
end

# Example usage
bestbuy_url = 'https://www.bestbuy.ca/en-ca/search?search=electronics'

Benchmark.bm do |x|
  x.report("Fetching URL:") do
    html = URI.open(bestbuy_url).read
  end

  x.report("Parsing HTML:") do
    products = parse_bestbuy(html)
  end

  puts "Best Buy Products: #{products.inspect}"
end
