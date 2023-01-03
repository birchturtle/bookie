require 'sqlite3'
require 'rspec'
require('./book')

private class Db
          def initialize(filename)
            @db = SQLite3::Database.new filename
          end
        end

class BookDb < Db
  def initialize(filename)
    super(filename)
    @db.execute <<-SQL
         CREATE TABLE IF NOT EXISTS Books (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Title varchar(255),
                Read int,
                AuthorId int,
                GenreId int,
                Priority int
                );
    SQL
  end

  def get_all_books
  end

  def get_books_per_author
  end

  def get_books_per_genre
  end

  def get_by_priority(num)
  end

  def add_book(b)
    @db.execute 'INSERT INTO Books(Title, Read, AuthorId, GenreId, Priority) VALUES ( ?, ?, ?, ?, ? )', b.title, fix_bool_for_sqlite(b.read?), b.author, b.genre, b.priority
  end

  def fix_bool_for_sqlite(bool)
    if bool.is_a?(Integer)
      bool == 1
    else
      if bool
        1
      else
        0
      end
    end
  end

  def get_by_name(name)
    cols = @db.execute 'SELECT * FROM Books WHERE Title = ?', name
    id, title, read, authorId, genreId, priority = cols[0]
    Book.new(id, title, fix_bool_for_sqlite(read), authorId, genreId, priority) unless id.nil?
  end
  private :fix_bool_for_sqlite
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

  def add_genre(g)
    @db.execute 'INSERT INTO Genres (Name, Type) VALUES ( ?, ? )', g.name, g.type unless g.name.nil? and g.type.nil?
  end

  def get_genre_by_name(g)
    cols = @db.execute 'SELECT * FROM Genres WHERE Name = ?', g
    id, name, type = cols[0]
    Genre.new(id, name, type) unless id.nil?
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

  def add_author(a)
    @db.execute 'INSERT INTO Authors (Name) VALUES ( ? )', a.name unless a.name.nil?
  end

  def get_author_by_name(name)
    cols = @db.execute 'SELECT * FROM Authors WHERE Name = ?', name
    id, name = cols[0]
    Author.new(id, name) unless id.nil?
  end
end
