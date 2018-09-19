class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  has_many :products, through: :order_details
  accepts_nested_attributes_for :order_details

  delegate :name, to: :user, prefix: true

  scope :all_order, ->{select :id, :user_id, :created_at, :status, :total}
  scope :new_order, -> time{where("created_at > ?", "#{time}")}
  scope :by_user, -> {group(:user_id).order("count_all desc").count.first(10)}
  scope :revenue_by_week, -> {group_by_week(:created_at).sum(:total)}
  scope :revenue_by_month, -> {group_by_month(:created_at).sum(:total)}

  enum status: {pending: 0, delivered: 1, canceled: 2}

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end
end
