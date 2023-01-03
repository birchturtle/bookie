require 'rspec'
require './book'
require './db'

describe 'author database' do
  before(:context) do
    File.delete('./test.sqlite3') if FileTest.exists? './test.sqlite3'
    expect(FileTest.exists?('./test.sqlite3')).to eq(false)
    @authorDb = AuthorDb.new('test.sqlite3')
  end

  it 'creates table on init' do
    expect(@authorDb.class).to eq(AuthorDb)
  end

  it 'can add an author' do
    author = Author.new(1, 'Test Testesen')
    author_retrieved = @authorDb.get_author_by_name(author.name)

    expect(author_retrieved.nil?).to eq(true)

    @authorDb.add_author(author)
    author_retrieved = @authorDb.get_author_by_name(author.name)

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
    @genreDb = GenreDb.new('test.sqlite3')
  end

  it 'can add a genre' do
    genre = Genre.new(1, 'horror', 'fiction')
    genreRetrieved = @genreDb.get_genre_by_name(genre.name)

    expect(genreRetrieved.nil?).to eq(true)

    @genreDb.add_genre genre
    genreRetrieved = @genreDb.get_genre_by_name(genre.name)

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
    @authorDb = AuthorDb.new('test.sqlite3')
    @genreDb = GenreDb.new('test.sqlite3')
    @bookDb = BookDb.new('test.sqlite3')
  end

  it 'can add a book' do
    author = Author.new(1, 'Frank Herbert')
    genre = Genre.new(1, 'Science Fiction', 'Fiction')
    @authorDb.add_author(author)
    @genreDb.add_genre(genre)

    book = Book.new(1, 'Dune', false, author.id, genre.id, 12)
    retrievedBook = @bookDb.get_by_name('Dune')

    expect(retrievedBook.nil?).to eq(true)

    @bookDb.add_book(book)
    retrievedBook = @bookDb.get_by_name('Dune')

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
