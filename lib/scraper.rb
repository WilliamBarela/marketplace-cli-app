class Scraper

  def self.scrape_home_page(home_url)

  end

  def self.scrape_article(article_url)

  end

  def self.sashimi(url="https://www.marketplace.org/")
    Nokogiri::HTML(open(url))
  end
end
