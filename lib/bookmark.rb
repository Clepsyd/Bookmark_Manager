# frozen_string_literal: true

require 'pg'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    connection = select_env

    result = connection.exec('SELECT * FROM bookmarks;')
    bookmarks = []
    result.each do |bookmark|
      bookmarks << Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])
    end
    bookmarks
  end

  def self.create(url, title)
    return false unless is_url?(url)

    connection = select_env

    result = connection.exec("INSERT INTO bookmarks (title, url) VALUES('#{title}', '#{url}') RETURNING id, url, title")
    # Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
    result
  end

  def self.delete(id)
    connection = select_env
    connection.exec("DELETE FROM bookmarks WHERE id = '#{id}'")
  end

  def self.is_url?(url)
    url
  end

  private

  def self.select_env
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'bookmark_manager_test')
    else
      PG.connect(dbname: 'bookmark_manager')
    end
  end
end
