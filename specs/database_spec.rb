require 'rspec'
require './book'
require './database'

describe 'author database' do
  before(:context) do
    File.delete('./test.sqlite3') if FileTest.exists? './test.sqlite3'
    expect(FileTest.exists?('./test.sqlite3')).to eq(false)
    @author_db = AuthorDb.new('test.sqlite3')
  end

  it 'creates table on init' do
    expect(@author_db.class).to eq(AuthorDb)
  end

  it 'can add an author' do
    author = Author.new(1, 'Test Testesen')
    author_retrieved = @author_db.get_author_by_name(author.name)

    expect(author_retrieved.nil?).to eq(true)

    @author_db.add_author(author)
    author_retrieved = @author_db.get_author_by_name(author.name)

    expect([author_retrieved.id, author_retrieved.name]).to eq([author.id, author.name])
  end

  after(:context) do
    File.delete('./test.sqlite3')
  end
end

describe 'genre database' do
  before(:context) do
    File.delete('./test.sqlite3') if FileTest.exists? './test.sqlite3'
    expect(FileTest.exists?('./test.sqlite3')).to eq(false)
    @genre_db = GenreDb.new('test.sqlite3')
  end

  it 'can add a genre' do
    genre = Genre.new(1, 'horror', 'fiction')
    genreRetrieved = @genre_db.get_genre_by_name(genre.name)

    expect(genreRetrieved.nil?).to eq(true)

    @genre_db.add_genre genre
    genreRetrieved = @genre_db.get_genre_by_name(genre.name)

    expect([genreRetrieved.id, genreRetrieved.name, genreRetrieved.type]).to eq([genre.id, genre.name, genre.type])
  end

  after(:context) do
    File.delete('./test.sqlite3')
  end
end

describe 'book database' do
  before(:context) do
    File.delete('./test.sqlite3') if FileTest.exists? './test.sqlite3'
    expect(FileTest.exists?('./test.sqlite3')).to eq(false)
    @author_db = AuthorDb.new('test.sqlite3')
    @genre_db = GenreDb.new('test.sqlite3')
    @book_db = BookDb.new('test.sqlite3')
  end

  it 'can add a book' do
    author = Author.new(1, 'Frank Herbert')
    genre = Genre.new(1, 'Science Fiction', 'Fiction')
    @author_db.add_author(author)
    @genre_db.add_genre(genre)

    book = Book.new(1, 'Dune', false, author.id, genre.id, 12)
    retrievedBook = @book_db.get_by_name('Dune')

    expect(retrievedBook.nil?).to eq(true)

    @book_db.add_book(book)
    retrievedBook = @book_db.get_by_name('Dune')

    expect([
             retrievedBook.id,
             retrievedBook.title,
             retrievedBook.read?,
             retrievedBook.author,
             retrievedBook.genre,
             retrievedBook.priority
           ])
      .to eq([
               book.id,
               book.title,
               book.read?,
               book.author,
               book.genre,
               book.priority
             ])
  end

  after(:context) do
    File.delete('test.sqlite3')
  end
end
