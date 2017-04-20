class Scraper

  def self.scrape_home_page(home_url="https://www.marketplace.org/")
    page = Scraper.sashimi(home_url)
    articles = page.css(".river-collection .feat-1")
    articles.collect do |article|
      {}.tap do |hash|
        hash[:headline] = article.css(".river--hed a").text
        hash[:authors] = article.css(".river-byline").css("a").collect{|author| author.text}
        hash[:date] = article.css(".river--time").text
        hash[:teaser] = article.css(".dek").text
        hash[:link] = article.css(".river--hed a").attr("href").value
      end
    end
  end

  def self.scrape_article(article_url="https://www.marketplace.org/2017/04/18/business/how-charles-shaw-wine-became-two-buck-chuck")
    article = self.sashimi(article_url)
    text = article.css(".article-body")
    # {}.tap do |hash|
    #
    # end
  end

  def self.sashimi(url)
    Nokogiri::HTML(open(url).read, nil, 'utf-8')
  end
end
