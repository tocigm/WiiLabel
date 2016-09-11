class Article
  include Mongoid::Document
  field :name, type: String
  embedded_in :Comment
end
