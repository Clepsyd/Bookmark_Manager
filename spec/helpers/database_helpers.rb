# frozen_string_literal: true

require 'pg'

def database_connect
  PG.connect(dbname: 'bookmark_manager_test')
end

def get_table(table)
  db = database_connect
  results = []
  db.exec("SELECT * from #{table};").each { |row|
    results << row
  }
  results
end

def add_2_bookmarks
  db = database_connect
  db.exec(
    "INSERT INTO bookmarks(url, title) VALUES ('www.google.com', 'Google'), ('www.facebook.com', 'Facebook')"
  )
end