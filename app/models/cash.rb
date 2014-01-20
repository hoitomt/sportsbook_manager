class Cash
  include DataMapper::Resource

  storage_names[:default] = "cash"

  property :id, Serial
  property :tag_id, Integer
  property :amount, Float

  belongs_to :tag

  validates_within :amount, :set => 1..1000

end
