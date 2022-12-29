This repo includes a simple Ruby script to extract URLs from a given set of RSS feed URLs.

Prerequisites:
* Ruby
* bundler

Steps:

1. `bundle install` the necessary gems
1. Create a file called `feed_urls.txt` in the root directory, and paste a list of RSS feed URLs. See `sample_feed_urls.txt` for the required format.
1. Run `ruby extract_urls_from_feeds.rb`

Extracted URLs will be written to a single, timestamped file in the `extracted_urls` directory.
