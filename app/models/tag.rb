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
    Tag.new(data)
  end

  def self.default_sort
    {:sort => {'name' => :desc}}
  end

  def self.dao
    MongoDao.new(COLLECTION)
  end

  def id
    @_id.to_s
  end

  def save
    Tag.dao.upsert(id_query, persist_attributes)
  end

  def update(params)
    self.attributes = self.attributes.merge(params[:tag])
    save
  end

  def delete
    Tag.dao.remove(_id)
  end

  def persist_attributes
    pa = self.attributes.dup
    pa.delete(:_id) if _id.blank?
    pa
  end

  def id_query
    {'_id' => _id}
  end

end