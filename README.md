# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
ruby 3.0.2p107 (2021-07-07 revision 0db68f0233) [x86_64-linux-gnu]
Rails 7.1.3.4

* Configuration
gem 'nokogiri'  # For HTML parsing
gem 'httparty'  # For making HTTP requests


* Database creation

rails generate model Product name:string price:decimal website:string url:string
rails db:migrate


* Testing 
Run rake crawler:fetch_prices

ruby app/service/scrape_bestbuy.rb to test individual file

curl -I 'https://www.bestbuy.ca/en-ca' to check connection

