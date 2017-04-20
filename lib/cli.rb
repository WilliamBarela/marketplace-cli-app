class Cli

  def self.run
    # orders methods
  end

  def pull_articles
    Article.create_from_collection(Scraper.scrape_home_page)
  end

  def add_articles_info
    Article.all.each do |article|
      hash = Scrape.scrape_article(article.link)
      article.add_article_attributes(hash)
    end
  end

  def cli_loop
    # loops allowing users to make selections
  end
end
