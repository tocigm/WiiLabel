class Item
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :category, type: String
  field :name, type: String
  field :description, type: String
  field :currency, type: String
  field :price, type: String
  field :item_id, type: String
  field :image_urls, type: String
  field :source, type: String
  field :page_id, type: String
  field :page_url, type: String
  field :tags, type: String
  field :status, type:String, default: "unchecked"
  embeds_many :images

  accepts_nested_attributes_for :images,  :autosave => true
end
