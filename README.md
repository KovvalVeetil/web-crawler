# Web Crawler

This project is a Ruby-based web scraper designed to gather data from various e-commerce websites, such as Amazon, Newegg, and BestBuy. It extracts product details like name, price, and URL for items listed under specific search queries.

## Features
- Scrapes Product Data: Extracts product names, prices, and URLs from Amazon, Newegg, and BestBuy.
- Supports Multiple Websites: Easily extendable to include additional websites.
- Logs Errors and Response Times: Includes basic logging for errors and performance tracking.


* Ruby version
ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]
Rails 7.1.3.4

* Configuration
gem 'nokogiri'  # For HTML parsing
gem 'httparty'  # For making HTTP requests


* Database creation

```bash
rails generate model Product name:string price:decimal website:string url:string
rails db:migrate
```

* Testing
 ```bash
Run rake crawler:fetch_prices

ruby app/service/scrape_bestbuy.rb to test individual file

curl -I 'https://www.bestbuy.ca/en-ca' to check connection
```
