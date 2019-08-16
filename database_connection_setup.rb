require './lib/database_connection'

TEST_DB = 'bookmark_manager_test'
PROD_DB = 'bookmark_manager'

DB = ENV['ENVIRONMENT'] == 'test' ? TEST_DB : PROD_DB

DatabaseConnection.setup(DB)