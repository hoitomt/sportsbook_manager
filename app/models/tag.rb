class Tag
  include DataMapper::Resource

  property :id, Serial
  property :name,      String
  property :amount,    Float

  has n, :ticket_tags
  has n, :tickets, :through => :ticket_tags
end
