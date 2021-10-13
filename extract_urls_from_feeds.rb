require 'tempfile'
require 'feedjira'
require 'http'
require 'pry'
#require 'pry-byebug'

urls = File.open('feed_urls.txt').read.split

Feedjira.logger.level = 3

urls.each do |url|
  puts "getting #{url}"
  uri = URI(url)
  raw = HTTP.get(url).to_s
  feed = Feedjira.parse(raw)
  if feed.entries
    feed.entries.each do |entry|
      entry_uri = URI(entry.url)
      entry_uri.host = uri.host unless entry_uri.host
      entry_uri.scheme = uri.scheme
      puts entry_uri.to_s
    end
  end
rescue => e
  puts "error processing #{url}: #{e}"
end
