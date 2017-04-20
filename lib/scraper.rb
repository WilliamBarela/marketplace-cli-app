class Scraper

  def self.scrape_home_page(home_url="https://www.marketplace.org/")
    page = Scraper.sashimi(home_url)
    articles = page.css(".river-collection .feat-1")
    articles.collect do |article|
      {}.tap do |hash|
        hash[:headline] =
        hash[:authors] =
        hash[:date] =
        hash[:teaser] =
        hash[:link] =
      end
    end
  end

  def self.scrape_article(article_url)

  end

  def self.sashimi(url)
    Nokogiri::HTML(open(url).read, nil, 'utf-8')
  end
end
