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
