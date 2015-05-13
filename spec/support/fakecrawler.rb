class Fakecrawler
  include Yasf::Crawler

  property :page_title, xpath: '/html/head/title', strip: true

  collection :books, xpath: '//*[@id="content"]/div/article' do

    property :title, xpath: 'header/h2/a/@title' do |data|
      data.to_s.upcase
    end

    property :description, xpath: 'div/p', strip: false

    property :download, xpath: 'div/p/a' do
      fields :href, :title
    end

  end

end

