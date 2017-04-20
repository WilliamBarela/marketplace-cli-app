class Article
  attr_accessor # add attributes which are expected from article hash
  @@all = []

  def initialize(article_hash)

  end

  def self.create_from_collection(article_array)

  end

  def add_article_attributes(attributes_hash)
    attributes_hash.each{|key, value| self.send(("#{key}="),value)}
    self
  end

  def self.all
    @@all
  end
end
