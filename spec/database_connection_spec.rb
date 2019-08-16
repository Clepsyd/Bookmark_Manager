require 'database_connection'

describe DatabaseConnection do

  describe '::setup' do
    it 'sets up the connection to the db' do
      conn = described_class.setup('bookmark_manager_test')
      sql = 'SELECT * FROM bookmarks;'
      sql_query = database_connect.exec(sql).to_a
      expect(conn).to be_a(PG::Connection)
      expect(conn.exec(sql).to_a).to eq sql_query
    end

    it 'this connection is persistent' do
      connection = DatabaseConnection.setup('bookmark_manager_test')
      expect(DatabaseConnection.connection).to eq connection
    end
  end
  
  describe '::query' do
    it 'sends a query to the db' do
      described_class.setup('bookmark_manager_test')
      results = get_table('bookmarks').to_a
      sql = 'SELECT * FROM bookmarks;'
      expect(described_class.query(sql).to_a).to eq results
    end
  end

end