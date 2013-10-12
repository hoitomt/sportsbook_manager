class Tag
  include Virtus

  COLLECTION = "tags"

  attribute :_id,       BSON::ObjectId
  attribute :name,      String
  attribute :amount,    Float

  def self.all
    dao.all(default_sort).each_with_object([]) do |tag_data, a|
      a << Tag.new(tag_data)
    end
  end

  def self.find(id)
    b_id = BSON.ObjectId(id)
    data = dao.find_one({_id: b_id})
    p "DB Result #{data}"
    Tag.new(data)
  end

  def self.default_sort
    {:sort => {'name' => :desc}}
  end

  def self.dao
    MongoDao.new(COLLECTION)
  end

  def save
    p "Attributes #{persist_attributes}"
    Tag.dao.save(persist_attributes)
  end

  def persist_attributes
    pa = self.attributes.dup
    pa.delete(:_id)
    pa
  end

end