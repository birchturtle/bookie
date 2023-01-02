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
    puts "#{'not ' unless read?}read, considered to be #{@genre.name}"
    puts "priority: #{@priority}"
    puts ''
  end

  def read?
    @read
  end
end

class Author
  attr_reader :name, :id

  def initialize(id, name)
    @id = id
    @name = name
  end
end

class Genre
  attr_reader :name, :type, :id

  def initialize(id, name, type)
    @id = id
    @name = name
    @type = type
  end
end
