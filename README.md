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
    property :title, xpath: 'header/h2/a/@title'
    property :description, xpath: 'div/p'
    property :download, xpath: 'div/p/a/@href'
  end
end
```

###### The code above is gonna return the following hash:

```ruby
{
   "page_title" => "Home | Wow! eBook",
   "books" => [
      {
         "title" => "Android Application Security Essentials",
         "description" => "In today’s techno-savvy world, more and more parts of our lives are going digital...",
         "download" => "http://www.wowebook.com/book/android-application-security-essentials/#more-29745"
      }
   ]
}
```

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
