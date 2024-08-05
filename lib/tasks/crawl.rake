# lib/tasks/crawler.rake
namespace :crawler do
    desc "Fetch prices from Best Buy Canada and Newegg Canada"
    task fetch_prices: :environment do
      puts "Starting the web crawler..."
      crawler = CrawlerService.new
      products = crawler.crawl
  
      puts "Crawling completed. Here are the products found:"
      products.each do |product|
        puts "#{product.name} - $#{product.price} (#{product.website})"
        puts "URL: #{product.url}"
        puts "-" * 40
      end
    end
  end
  