class TicketTag
  include DataMapper::Resource

  property :id,         Serial
  property :ticket_id,  Integer
  property :tag_id,     Integer
  property :amount,     Float

  belongs_to :tag
  belongs_to :ticket

  validates_uniqueness_of :ticket_id, scope: :tag_id,
    message: "This ticket has already been tagged for this person"

  def tag
    Tag.get(tag_id)
  end

end
