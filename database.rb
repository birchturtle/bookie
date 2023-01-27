# frozen_string_literal: true

require 'sqlite3'
require 'rspec'
require('./book')

private class Database
          def initialize(filename)
            @db = SQLite3::Database.new filename
          end
        end

class BookDb < Database
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
    books = []
    rows = @db.execute 'SELECT * FROM BOOKS'
    rows.each do |row|
      id, title, read, author_id, genre_id, priority = row
      book = Book.new(id, title, fix_bool_for_sqlite(read), author_id, genre_id, priority) unless id.nil?
      books << book
    end
    books
  end

  def get_books_per_author; end

  def get_books_per_genre; end

  def get_by_priority(num = 10)
    books = []
    rows = @db.execute 'SELECT * FROM BOOKS ORDER BY Priority LIMIT ?', num
    rows.each do |row|
      id, title, read, author_id, genre_id, priority = row
      book = Book.new(id, title, fix_bool_for_sqlite(read), author_id, genre_id, priority) unless id.nil?
      books << book
    end
    books
  end

  def add_book(book)
    @db.execute 'INSERT INTO Books(Title, Read, AuthorId, GenreId, Priority) VALUES ( ?, ?, ?, ?, ? )', book.title,
                fix_bool_for_sqlite(book.read?), book.author, book.genre, book.priority
  end

  def update_book(book)
    @db.execute 'UPDATE Books SET Title=?, Read=?, AuthorID=?, GenreId=?, Priority=? WHERE Id = ?', book.title,
                fix_bool_for_sqlite(book.read?), book.author, book.genre, book.priority, book.id
  end

  def fix_bool_for_sqlite(bool)
    if bool.is_a?(Integer)
      bool == 1
    elsif bool
      1
    else
      0
    end
  end

  def get_by_name(name)
    cols = @db.execute 'SELECT * FROM Books WHERE Title = ?', name
    id, title, read, author_id, genre_id, priority = cols[0]
    Book.new(id, title, fix_bool_for_sqlite(read), author_id, genre_id, priority) unless id.nil?
  end
  private :fix_bool_for_sqlite
end

class GenreDb < Database
  def initialize(filename)
    super(filename)
    @db.execute <<-SQL
         CREATE TABLE IF NOT EXISTS Genres (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name varchar(255),
                Type varchar(255)
                );
    SQL
  end

  def add_genre(genre)
    return if genre.name.nil? || genre.type.nil?

    @db.execute 'INSERT INTO Genres (Name, Type) VALUES ( ?, ? )', genre.name, genre.type
  end

  def get_genre_by_name(genre_name)
    cols = @db.execute 'SELECT * FROM Genres WHERE Name = ?', genre_name
    id, name, type = cols[0]
    Genre.new(id, name, type) unless id.nil?
  end

  def get_genre_by_id(genre_id)
    cols = @db.execute 'SELECT * FROM Genres WHERE ID = ?', genre_id
    id, name, type = cols[0]
    Genre.new(id, name, type) unless id.nil?
  end

  def get_all_genres
    genres = []
    rows = @db.execute 'SELECT * FROM Genres'
    rows.each do |row|
      genres << Genre.new(*row)
    end
    genres
  end
end

class AuthorDb < Database
  def initialize(filename)
    super(filename)
    @db.execute <<-SQL
         CREATE TABLE IF NOT EXISTS Authors (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Name varchar(255)
                );
    SQL
  end

  def add_author(author)
    @db.execute 'INSERT INTO Authors (Name) VALUES ( ? )', author.name unless author.name.nil?
  end

  def get_all_authors
    authors = []
    rows = @db.execute 'SELECT * FROM Authors'
    rows.each do |row|
      authors << Author.new(*row)
    end
    authors
  end

  def get_author_by_name(name)
    cols = @db.execute 'SELECT * FROM Authors WHERE Name = ?', name
    id, name = cols[0]
    Author.new(id, name) unless id.nil?
  end

  def get_author_by_id(id)
    cols = @db.execute 'SELECT * FROM Authors WHERE Id = ?', id
    author_id, name = cols[0]
    Author.new(author_id, name) unless author_id.nil?
  end
end
