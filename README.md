# Yasf

Web scraper

## Usage:

``gem install yasf``


## Scraping a page:

The simplest way to use yasf is by calling ``Yasf.crawl`` and passing it a block:

```ruby

  require 'yasf'

  result = Yasf.crawl do
    base_url "http://www.wowebook.com"

    property :page_title, xpath: '/html/head/title'

    collection :books, xpath: '//*[@id="content"]/div/article' do

      property :title, xpath: 'header/h2/a/@title'do |data|
        data.to_s.upcase
      end

      property :description, xpath: 'div/p'

      property :download, xpath: 'div/p/a' do
        field :href
        field :title
      end
    end
  end

  puts result.page_title

  result.books.each do |book|
    puts "Book: #{book.title} -> #{book.description}"
  end

```

### [Wiki](http://github.com/algonauti/yasf/wiki)

## Copyright

Copyright (c) 2014 Algonauti
