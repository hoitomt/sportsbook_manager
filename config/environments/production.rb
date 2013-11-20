configure do
  # Mongo production settings
end

DataMapper.setup(:default, ENV['DATABASE_URL'])