class Product < ApplicationRecord
  belongs_to :category
  has_many :likes
  has_many :ratings
  has_many :comments, dependent: :destroy
  has_many :order_details
  has_many :images
  has_many :promotion_details

  delegate :name, to: :category, prefix: true

  accepts_nested_attributes_for :images, allow_destroy: true,
    reject_if: proc { |attributes| attributes["image_url"].blank? }

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true,
    length: {maximum: Settings.product.validates.price_maximum},
    numericality: {only_integer: true, greater_than: 0}

  scope :get_product, ->{
    select :id, :name, :price, :description, :average_rating, :category_id
  }
  scope :like_most, ->{order "likes_count DESC"}
  scope :hot_product, ->{
    joins(:order_details).group("product_id").order("sum(quantity) DESC")
      .limit Settings.product.hot
  }
  scope :by_category, -> (category_id){where(id: category_id)}
  scope :by_average_rating, ->{group(:average_rating).count}

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |product|
        csv << product.attributes.values_at(*column_names)
      end
    end
  end

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(Settings.import.header)
    (Settings.import.row..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = Product.where(name: row["name"]).first
      category = Category.where(name: row["category"]).last
      product = Product.new(name: row["name"], price: row["price"],
        category_id: category.id) if product == nil
      images = row["images"].split(", ");
      images.each do |image|
        product.images.build(remote_image_url_url: image)
      end
      product.save
    end
  end

  def self.open_spreadsheet file
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path)
    when ".xlsx" then Roo::Excelx.new(file.path)
    else raise file.original_filename
    end
  end
end
