class Scraper

  def self.scrape_home_page(home_url="https://www.marketplace.org/")
    page = Scraper.sashimi(home_url)
    #articles = page.css("article .feat-1")
  end

  def self.scrape_article(article_url)

  end

  def self.sashimi(url="https://www.marketplace.org/")
    Nokogiri::HTML(open(url))
  end
end
