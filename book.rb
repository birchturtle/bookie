# frozen_string_literal: true

class Book
  attr_accessor :id, :title, :read, :author, :genre, :priority

  def initialize(id, title, read, author, genre, priority)
    @id = id
    @title = title
    @read = read
    @author = author
    @genre = genre
    @priority = priority
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
