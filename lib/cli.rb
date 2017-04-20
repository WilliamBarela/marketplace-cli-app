class Cli

  def run
    self.clear
    self.pull_articles
    self.add_articles_info
    self.start_message
    self.cli_loop
    self.exit_message
  end

  def pull_articles
    puts "Loading articles for the day..."
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
      input = gets.strip.downcase
      case input
        when "list"
          self.list
        when "man"
          self.man
        when "about"
          self.about
        when "exit"
          self.clear
        else
          puts "Please type " + "man".colorize(:red) + " to see the list of commands"
      end
    end
    # loops allowing users to make selections
  end

  def list
    self.clear
    puts "Marketplace Top Stories of the Day\n\n".colorize(:white).on_green.bold

    self.articles.each_with_index do |article, i|
      puts " #{(i + 1).to_s} ".colorize(:white).on_red.bold + " " + article.headline.colorize(:blue).bold
      puts "     |_--#{article.teaser}\n\n"
    end
    puts "\nPlease select an article to read"
    # case input
    # when condition
    #
    # end
  end

  def man

  end

  def about

  end

  def articles
    @articles = Article.all
  end

  def clear
    system("clear")
  end

  def start_message
    self.clear
    puts "Welcome to the Marketplace Gem!\n" \
         "Type " + "man".colorize(:red).bold + " for commands, " +
         "about".colorize(:blue).bold + " for info, and " +
         "list".colorize(:green).bold + " for today's articles"
  end

  def exit_message
    puts "Thank you for using this Gem and listening to Marketplace!"
  end
end
