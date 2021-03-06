class DatabaseConnection

  require 'pg'

  def self.setup(database)
    @connection = PG.connect(dbname: database)
  end

  def self.query(sql_string)
    connection.exec(sql_string)
  end

  def self.connection
    @connection
  end
end