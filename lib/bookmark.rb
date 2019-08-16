# frozen_string_literal: true

require 'pg'
require 'database_connection'

class Bookmark
  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')
    bookmarks = []
    result.each do |bookmark|
      bookmarks << Bookmark.new(
        bookmark['id'],
        bookmark['title'],
        bookmark['url']
      )
    end
    bookmarks
  end

  def self.create(url, title)
    result = DatabaseConnection.query(
      "INSERT INTO bookmarks (title, url)
      VALUES('#{title}', '#{url}')
      RETURNING id, url, title"
    )
    # Bookmark.new(result[0]['id'], result[0]['title'], result[0]['url'])
    result
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}';")
  end

  def self.update(id, title, url)
    DatabaseConnection.query(
      "UPDATE bookmarks
      SET title = '#{title}', url = '#{url}'
      WHERE id = #{id}"
    )
  end

  def self.find(id)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}").first
    return Bookmark.new(result['id'], result['title'], result['url'])
  end

end
