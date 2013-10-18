class MongoDao
  CLIENT = Sinatra::Application.settings.mongo_client
  DB_NAME = Sinatra::Application.settings.mongo_database_name

  def initialize(collection_name)
    @collection_name = collection_name
  end

  def all(args)
    @args = args
    collection.find.send(:sort, sort_args).to_a
  end

  def sort_args
    p "Args #{@args}"
    @args[:sort]
  end

  def upsert(query, doc)
    save(doc) unless update_doc(query, doc)
  end

  def save(doc=nil)
    collection.insert(doc) if doc
  end

  def update_doc(query, doc)
    update = collection.update(query, doc)
    update['updatedExisting']
  end

  # update_attributes: {'attr_name' => attr_value}
  def update(id, update_attributes)
    update = collection.update({"_id" => id}, {"$set" => update_attributes})
    update['updatedExisting']
  end

  def id(query)
    find_one(query)['_id']
  end

  def find(query)
    collection.find(query).to_a
  end

  def find_one(query)
    p "Query #{query}"
    find(query).first || {}
  end

  def present?(query)
    !blank?(query)
  end

  def blank?(query)
    find_one(query).empty?
  end

  def remove(id)
    record = collection.find_one({'_id' => id})
    collection.remove(record)
  end

  private

  def collection
    db[collection_name]
  end

  def db
    CLIENT.db(DB_NAME)
  end

  def collection_name
    @collection_name
  end

end