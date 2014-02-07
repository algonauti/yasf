# Yasf

Web scraper with an elegant DSL that parses structured data from web pages.

## Usage:

``gem install yasf``


## Scraping a page:

The simplest way to use yasf is by calling ``Yasf.crawl`` and passing it a block:

```ruby
require 'yasf'

Yasf.crawl do
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
```

###### The code above is gonna return the following OpenStruct:


### This is just a sneak peek of what Yasf can do. For the complete documentation, please check the links below:

### [Wiki](http://github.com/algonauti/yasf/wiki)

## Contributing to Yasf

 * Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
 * Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
 * Fork the project
 * Start a feature/bugfix branch
 * Commit and push until you are happy with your contribution
 * Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.



## Copyright

Copyright (c) 2014 Algonauti
