class Article
  attr_accessor # add attributes which are expected from article hash
  @@all = []

  def initialize(article_hash)
    self.add_article_attributes(article_hash)
    @@all << self
  end

  def self.create_from_collection(article_array)
    article_array.each{|article_hash| Article.new(article_hash)}
  end

  def add_article_attributes(article_hash)
    article_hash.each{|key, value| self.send(("#{key}="),value)}
    self
  end

  def self.all
    @@all
  end
end
