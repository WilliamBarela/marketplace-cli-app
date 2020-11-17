class Cli

  def run
    self.clear
    self.pull_articles
    self.add_articles_info
    self.cli_loop
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
      self.clear
      case input
        when "list"
          self.list
        when "man"
          self.man
        when "about"
          self.about
        when "exit"
          self.exit_message
        else
          puts "Please type " + "man".colorize(:red) + " to see the list of commands"
      end
    end
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
      puts " #{(i + 1).to_s} ".colorize(:white).on_red.bold + " " + article.headline.colorize(:magenta).bold
      puts "     |_--#{article.teaser}"
      puts "     |_--#{" READ ".colorize(:black).on_white} #{(article.audio_link != nil) ? " LISTEN ".colorize(:white).on_cyan.bold : ""}\n\n"
    end
  end

  def select_article
    command = ""
    until command == "exit" || command == "back"
      command = gets.strip.downcase
      self.clear
      case command
        when /rl (\d+)/
          self.read_listen_select_article(command)
        when /(l|listen) (\d+)/
          self.listen_select_article(command)
        when /(r|read) (\d+)/
          self.select_read_article(command)
        when "list"
          self.display_index_page
          puts "\nPlease select an article to read"
        when "exit"
          self.exit_message
        when "back"
          self.cli_loop
        else
          self.display_index_page
          puts "Please enter a valid command, eg: " + "read 4".colorize(:red) + ", " +
               "listen 3".colorize(:red) + ", " +
               "r 4".colorize(:red) + ", " +
               "l 3".colorize(:red) + ", or "  +
               "rl 7".colorize(:red)
      end
    end
  end

  def select_read_article(command)
    i = command.match(/(r|read) (\d+)/)[2].to_i - 1
    if Article.readable.include?(i)
      article = self.articles[i]
      self.read(article)
      self.back_message
    else
      self.invalid_selection
    end
  end

  def listen_select_article(command)
    option = command.match(/(l|listen) (\d+)/)[2]
    i = option.to_i - 1
    if Article.audible.include?(i)
      article = self.articles[i]
      self.listen(article)
      self.back_message
    elsif Article.readable.include?(i)
      self.display_index_page
      puts "Unfortunately article #{" #{option} ".colorize(:white).on_red.bold} does not contain audio"
      puts "Please select another article to listen to, or read this one!"
    else
      self.invalid_selection
    end
  end

  def read_listen_select_article(command)
    option = command.match(/rl (\d+)/)[1]
    i = option.to_i - 1
    if Article.audible.include?(i) && Article.readable.include?(i)
      article = self.articles[i]
      self.read(article)
      self.listen(article)
      self.back_message
    else
      listen_command = "l #{option}"
      listen_select_article(listen_command)
    end
  end

  def invalid_selection
    self.display_index_page
    puts "\nInvalid article chosen! No such article exists. Please choose another".colorize(:blue).on_yellow.bold
  end

  def read(article)
    puts article.headline.colorize(:white).on_green.bold
    puts "Author(s): " + article.authors.join(", ")
    puts "Date: " + article.date + "\n\n"
    article.paragraphs.each {|p| puts " #{p}\n\n"}
  end

  def listen(article)
    # FIXME: due to a change in the code base of marketplace, this method may no longer work. Fix scrapper and revisit
    # system(%Q[google-chrome --disable-gpu --disable-software-rasterizer --app="data:text/html,<html><body><script>window.moveTo(20,20);window.resizeTo(700,250);window.location='#{article.audio_link}';</script></body></html>"])
    # system(%Q[google-chrome --app="data:text/html,<html><body><script>window.moveTo(20,20);window.resizeTo(700,250);window.location='#{article.audio_link}';</script></body></html> &"])
  end

  def back_message
    puts "\n\nPlease type #{'list'.colorize(:red)} to go back"
  end

  def man
    self.start_message
    puts "\n\nWelcome to the Manual of Marketplace\n\n"
    puts "After typing " + " list ".colorize(:white).on_green.bold + ":\n\n"
    puts "   " + " read 2 ".colorize(:black).on_white.bold + " opens the second article to read\n\n"
    puts "   " + " r 2 ".colorize(:black).on_white.bold + " opens the second article to read (SHORTCUT)\n\n"
    puts "   " + " listen 5 ".colorize(:white).on_cyan.bold + " opens the fifth article to listen to\n\n"
    puts "   " + " l 5 ".colorize(:white).on_cyan.bold + " opens the fifth article to listen to (SHORTCUT)\n\n"
    puts "   " + " rl 9 ".colorize(:white).on_blue.bold + " opens the ninth article to read AND listen to\n\n"
    puts "   " + " exit ".colorize(:white).on_red.bold + " to terminate the program\n\n"
  end

  def about
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
