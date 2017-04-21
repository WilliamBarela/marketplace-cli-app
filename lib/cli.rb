class Cli

  def run
    self.clear
    self.pull_articles
    self.add_articles_info
    self.cli_loop
    #self.exit_message
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
    self.start_message
    input = ""
    until input == "exit" || input == "list"
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
          self.exit_message
        else
          puts "Please type " + "man".colorize(:red) + " to see the list of commands"
      end
    end
    # loops allowing users to make selections
  end

  def list
    self.display_index_page
    puts "\nPlease select an article to read"
    self.select_article
  end

  def display_index_page
    self.clear
    puts "Marketplace Top Stories of the Day\n\n".colorize(:white).on_green.bold

    self.articles.each_with_index do |article, i|
      puts " #{(i + 1).to_s} ".colorize(:white).on_red.bold + " " + article.headline.colorize(:blue).bold
      puts "     |_--#{article.teaser}"
      puts "     |_--#{"READ".colorize(:white).on_yellow.bold} #{(article.audio_link != nil) ? "LISTEN".colorize(:white).on_magenta.bold : ""}\n\n"
    end
  end

  def select_article
    command = ""
    until command == "exit" || command == "back"
      command = gets.strip.downcase
      case command
        when /rl (\d+)/
          self.clear
          i = command.match(/rl (\d+)/)[1].to_i - 1
          article = self.articles[i]
          self.read(article)
          self.listen(article)
          self.back_message
        when /(l|listen) (\d+)/
          self.clear
          i = command.match(/(l|listen) (\d+)/)[1].to_i - 1
          article = self.articles[i]
          self.listen(article)
          self.back_message
        when /(r|read) (\d+)/
          self.clear
          i = command.match(/(r|read) (\d+)/)[1].to_i - 1
          article = self.articles[i]
          self.read(article)
          self.back_message
        when "list"
          self.display_index_page
          puts "\nPlease select an article to read"
        when "exit"
          self.clear
          self.exit_message
        when "back"
          self.clear
          self.cli_loop
        else
          self.display_index_page
          puts "Please enter a valid command, eg: " + "read 4".colorize(:red) + ", " +
               "listen 3".colorize(:red) + ", " +
               "r 4".colorize(:red) + ", or "  +
               "l 3".colorize(:red)
      end
    end
  end

  def read(article)
    puts article.headline.colorize(:white).on_green.bold
    article.paragraphs.each {|p| puts " #{p}\n\n"}
  end

  def listen(article)
    system(%Q[chrome --app="data:text/html,<html><body><script>window.moveTo(20,20);window.resizeTo(700,250);window.location='#{article.audio_link}';</script></body></html>"])
  end

  def back_message
    puts "\n\nPlease type #{'list'.colorize(:red)} to go back"
  end

  def man
    self.clear
    self.start_message
    puts "\n\nthis is the man"
  end

  def about
    self.clear
    self.start_message
    puts "\n\nWelcome to the Marketplace CLI Gem."
    puts "Here you can listen to and read the latest articles from Marketplace"
    puts "Programmed by: William Barela"
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
