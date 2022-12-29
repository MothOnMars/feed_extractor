# frozen_string_literal: true

require 'feedjira'
require 'http'
require 'pry'
require 'pry-byebug'

urls = File.open('feed_urls.txt').read.split

Feedjira.logger.level = 3

@file = File.open("extracted_urls/#{Time.now.strftime('%Y_%m_%d_%T')}.txt", 'w')

def process_entry(entry)
  uri = URI(entry.url.strip)
  # convert all URLs to 'https'
  uri.scheme = 'https'
  @file.puts uri.to_s
rescue => e
  puts "Error processing entry: #{entry.to_json}. #{e}"
end

urls.each do |url|
  puts "Fetching #{url}"
  # raise an error for invalid URLs
  uri = URI(url)
  raw = HTTP.follow.get(uri).to_s
  feed = Feedjira.parse(raw)
  feed.entries&.each { |entry| process_entry(entry) }
rescue => e
  puts "Error processing feed #{url}: #{e}: #{e.backtrace.first}"
end

@file.close

puts "Extracted URLs have been written to: #{@file.path}"
