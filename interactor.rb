# frozen_string_literal: true

require('./book')
require('./database')

class Interactor
  def initialize(database_file)
    @author_db = AuthorDb.new(database_file)
    @book_db = BookDb.new(database_file)
    @genre_db = GenreDb.new(database_file)
  end

  def add_book
    puts 'Title?'
    title = gets.strip
    puts 'Author? Note: Must match existing name in author database'
    author_name = gets.strip
    author = get_dependency_entity_by_name(:author, author_name)
    puts 'Genre? Note: Must match existing name in genre database'
    genre_name = gets.strip
    genre = get_dependency_entity_by_name(:genre, genre_name)
    puts "Read? ('y' or 'n')"
    read = gets.strip == 'y'
    puts 'Priority? (0 highest, ...n lowest)'
    priority = gets.strip.to_i
    @book_db.add_book(Book.new(nil, title, read, author.id, genre.id, priority))
    book = @book_db.get_by_name(title)
    if book.nil?
      puts "Failed to add #{title}"
      exit 1
    end
    puts 'Book added successfully!'
    summarize_book(book, author, genre)
  end

  def delete_book
    puts 'Title?'
    title = gets.strip
    book = @book_db.get_by_name title
    if book.nil?
      puts 'Book not found'
    else
      puts 'Found book.'
    end

  end

  def list_book
    puts 'Listing book(s)!'
  end

  def add_author
    handler = Author_Handler.new
    handler.add_author @author_db
  end

  def list_author
    handler = Author_Handler.new
    handler.list_author @author_db
  end

  def delete_author
    handler = Author_Handler.new
    handler.delete_author @author_db
  end

  def add_genre
    handler = Genre_Handler.new
    handler.add_genre @genre_db
  end

  def delete_genre
    puts 'Deleting genre!'
  end

  def list_genre
    puts 'Listing genre(s)!'
  end

  private

  def summarize_book(book, author, genre)
    puts "Title: #{book.title} (by #{author.name})"
    puts "#{'not ' unless book.read?}read, considered to be #{genre.name} (#{genre.type})"
    puts "priority: #{book.priority}"
    puts ''
  end

  def get_dependency_entity_by_name(type, name)
    db = get_entity_database_by_type(type)
    entity = db.send("get_#{type.to_s}_by_name")
    if entity.nil?
      puts "Error: #{name} does not exist. Please add it first."
      exit 0
    end
    entity
  end

  def get_entity_database_by_type(type)
    case type
    when :author
      @author_db
    when :genre
      @genre_db
    else
      exit 1
    end
  end
end

class Genre_Handler
  def add_genre(genre_db)
    puts 'Name?'
    name = gets.strip
    puts "Type? ('f' for fiction, 'nf' for non-fiction)"
    type = case gets.strip
           when 'f'
             'Fiction'
           when 'nf'
             'Non-Fiction'
           else
             puts 'Sorry, unrecognized...'
             exit 1
           end
    genre_db.add_genre(Genre.new(nil, name, type))
    genre = genre_db.get_genre_by_name(name)
    if genre.nil?
      puts "Failed to add #{name} to genre database."
    else
      puts "Added #{genre.name} (#{genre.type}) to database successfully."
    end
  end
end

class Author_Handler
  def add_author(author_db)
    puts 'Name?'
    name = gets.strip
    author_db.add_author(Author.new(nil, name))
    author = author_db.get_author_by_name(name)
    if author.nil?
      puts 'Failed to add author'
    else
      puts "Added #{author.name} to the database succesfully."
    end
  end

  def delete_author(author_db)
    puts 'Deleting author!'
  end

  def list_author(author_db)
    puts 'Listing author(s)!'
  end
end