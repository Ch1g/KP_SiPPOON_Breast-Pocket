require "sinatra/activerecord"

set :database, "sqlite3:database/story_dev"

module CRUD
  class Crm < ActiveRecord::Base
  end

  class User < ActiveRecord::Base
  end

  class Version < ActiveRecord::Base
  end
end

