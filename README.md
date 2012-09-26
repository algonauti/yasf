yasf
====

Yet Another Scraper Framework

## Installation

Add this line to your application's Gemfile:

    gem 'yasf'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yasf

## Usage  
    row_scraper = Yasf.define do
        scrape "h1.title", :title => :text
        scrape "a.brand",  :brand => :text, :brand_link => :href

        result :title, :brand, :brand_link
    end

    scraper = Yasf.define do
        scrape "table.companies tr.company", :'rows[]' => row_scraper
        result :rows
    end

And using the scraper:

  results = scraper.extract_from(html)

  # First result:
  result = results.first
  puts result.title

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request