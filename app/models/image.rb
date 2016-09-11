class Image
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :url, type: String
  field :path, type: String
  field :checksum, type: String
  field :status, type:String, default: 'O'
  embedded_in :item
end