require 'sqlite3'
require 'rspec'
require('./book')

private class Db
          def initialize(filename)
            @db = SQLite3::Database.new filename
          end
        end

class BookDb < Db
  def getAllBooks
  end

  def getBooksPerAuthor
  end

  def getBooksPerGenre
  end

  def getByPriority(num)
  end

  def addBook(b)
  end
end

class GenreDb < Db
  def initialize(filename)
    super(filename)
    rows = @db.execute <<-SQL
         CREATE TABLE IF NOT EXISTS Genres (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name varchar(255),
                Type varchar(255)
                );
    SQL
  end

  def addGenre(g)
  end
end

class AuthorDb < Db
  def initialize(filename)
    super(filename)
    rows = @db.execute <<-SQL
         CREATE TABLE IF NOT EXISTS Authors (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name varchar(255)
                );
    SQL
  end

  def addAuthor(a)
    @db.execute 'INSERT INTO Authors (Name) VALUES ( ? )', a.name
  end

  def getAuthorByName(name)
    cols = @db.execute 'SELECT * FROM Authors WHERE Name = ?', name
    id, name = cols[0]
    Author.new(id, name) unless id.nil?
  end
end
