class Cli
  def pull_articles
    Article.create_from_collection(Scraper.scrape_home_page)
  end

  def add_articles_info
    Article.all.each do |article|
      hash = Scrape.scrape_article(article.link)
      article.add_article_attributes(hash)
    end
  end
end
