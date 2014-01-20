class Tag
  include DataMapper::Resource

  property :id, Serial
  property :name,      String
  property :amount,    Float

  has n, :ticket_tags
  has n, :tickets, :through => :ticket_tags
  has n, :cash

  def total_cash
    cash.inject(0) {|total, tag| total += tag.amount} || 0
  end
end
