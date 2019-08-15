# frozen_string_literal: true

require 'bookmark'

describe Bookmark do
  let(:bookmark) { double('bookmark', url: 'http://www.testbookmark.com', title: 'Test Bookmark') }

  describe '::all' do
    it 'returns a list of bookmarks' do
      # connection = PG.connect(dbname: 'bookmark_manager_test')
      # connection.exec("INSERT INTO bookmarks (title, url) VALUES('Google')

      Bookmark.create('http://www.google.com', 'Google')
      Bookmark.create('http://lwlies.com', 'Little White Lies')
      Bookmark.create('http://ocado.com', 'Ocado')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      # expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Google'
      expect(bookmarks.first.url).to eq 'http://www.google.com'
    end
  end

  describe '::create' do
    it 'creates a new bookmark' do
      Bookmark.create(bookmark.url, bookmark.title)
      results = get_table('bookmarks')
      expect(results[0]['url']).to eq bookmark.url
      expect(results[0]['title']).to eq bookmark.title
    end
  end

  describe '::delete' do
    it 'deletes a bookmark' do
      add_2_bookmarks
      table_before = get_table('bookmarks').to_a
      first_bookmark = table_before.first
      Bookmark.delete(first_bookmark['id'])
      table_after = get_table('bookmarks').to_a
      expect(table_after).not_to include(first_bookmark)
    end
  end

  describe '::update' do
    it 'updates a bookmark' do
      add_2_bookmarks
      table_before = get_table('bookmarks').to_a
      first_bookmark = table_before.first
      Bookmark.update(
        first_bookmark['id'],
        title: "Amazon",
        url: "www.amazon.co.uk"
      )
      table_after = get_table('bookmarks').to_a
      expect(table_after).to include(
         {
          'id' => first_bookmark['id'],
          'title' => 'Amazon',
          'url' => "www.amazon.co.uk"
        }
      )
    end
  end
end
