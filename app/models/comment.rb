class Comment
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :content, type: String
  embeds_many :Article
end
