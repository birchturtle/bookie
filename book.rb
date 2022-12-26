class Book
  attr_reader :title, :read, :author, :genre, :priority
  def initialize(title, read, author, genre, priority)
    @title = title
    @read = read
    @author = author
    @genre = genre
    @priority = priority
  end
  def summarize
    puts "Title: #{@title} (by #{@author.name})"
    puts "#{"not " unless read?}read, considered to be #{@genre.name}"
    puts "priority: #{@priority}"
    puts ""
  end
  def read?
    @read
  end
end

class Author
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Genre
  attr_reader :name, :type
  def initialize(name, type)
    @name = name
    @type = type
  end
end

