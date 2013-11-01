class Tag
  include DataMapper::Resource

  property :id, Serial
  property :name,      String
  property :amount,    Float
end

DataMapper.finalize