class Cli

  def run
    self.pull_articles
    self.add_articles_info
    self.cli_loop
  end

  def pull_articles
    Article.create_from_collection(Scraper.scrape_home_page)
  end

  def add_articles_info
    Article.all.each do |article|
      hash = Scraper.scrape_article(article.link)
      article.add_article_attributes(hash)
    end
  end

  def cli_loop
    # loops allowing users to make selections
  end
end
