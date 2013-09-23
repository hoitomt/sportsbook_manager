class MongoDao
  CLIENT = Sinatra::Application.settings.mongo_client
  DB_NAME = 'mydb' #Sinatra::Application.settings.mongo_database_name

  class << self
    def all
      collection.find.to_a
    end

    def add_or_update(query, doc)
      save(doc) unless update(query, doc)
    end

    def save(doc=nil)
      collection.insert(doc) if doc
    end

    def update(query, doc)
      update = collection.update(query, doc)
      update['updatedExisting']
    end

    def id(query)
      find_one(query)['_id']
    end

    def find(query)
      collection.find(query).to_a
    end

    def find_one(query)
      find(query).first || {}
    end

    def present?(query)
      !blank?(query)
    end

    def blank?(query)
      find_one(query).empty?
    end

    private

    def collection
      db[collection_name]
    end

    def db
      CLIENT.db(DB_NAME)
    end

    def collection_name
      "testData"
    end
  end

end