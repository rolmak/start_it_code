# Make sure this is required before requiring 'rspec/rails',
# so that capybara after hooks run before the database cleanup.
RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.clean_with(:deletion)
  end
  config.before :each do
    DatabaseCleaner.strategy = :transaction
  end
  config.before :each, js: true do
    DatabaseCleaner.strategy = :deletion
  end
  config.before :each do
    DatabaseCleaner.start
  end
  config.after :each do
    DatabaseCleaner.clean
  end
end
