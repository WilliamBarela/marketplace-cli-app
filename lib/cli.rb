class Cli

  def run
    self.start_message
    self.pull_articles
    self.add_articles_info
    self.cli_loop
    self.exit_message
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
    input = ""
    until input == "exit"
      input = gets.strip
      case input
      when "list"
        self.list
      when "exit"
        puts "\n"
      else
        puts "Please type " + "man".colorize(:red) + " to see the list of commands"
      end
    end
    # loops allowing users to make selections
  end

  def list

  end

  def articles
    @articles = Articles.all
  end

  def start_message
    system("clear")
    puts "Welcome to the Marketplace Gem!\n" \
         "Type " + "man".colorize(:red).bold + " for commands, " +
         "about".colorize(:blue).bold + " for info, and " +
         "list".colorize(:green).bold + " for today's articles"
  end

  def exit_message
    puts "Thank you for using this Gem and listening to Marketplace!"
  end
end
