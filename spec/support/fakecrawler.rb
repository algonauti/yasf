class Fakecrawler
  include Yasf::Crawler

  base_url "http://www.wowebook.com"

  property :page_title, xpath: '/html/head/title'

  collection :books, xpath: '//*[@id="content"]/div/article' do

    property :title, xpath: 'header/h2/a/@title' do |data|
      data.to_s.upcase
    end

    property :description, xpath: 'div/p'

    property :download, xpath: 'div/p/a' do
      fields :href, :title
    end

  end

end

