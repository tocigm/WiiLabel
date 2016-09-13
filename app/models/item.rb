class Item
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  field :category, type: String
  field :description, type: String
  field :tags, type: String
  field :price, type: String
  field :title, type: String
  field :item_id, type: String
  field :image_urls, type: String
  field :source, type: String
  field :page_id, type: String
  field :page_url, type: String
  field :status, type:String, default: "New"
  embeds_many :images

  accepts_nested_attributes_for :images,  :autosave => true
end
