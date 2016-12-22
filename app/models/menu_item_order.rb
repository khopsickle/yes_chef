class MenuItemOrder < ApplicationRecord
  before_save :set_price

  belongs_to :menu_item, inverse_of: :menu_item_orders
  belongs_to :order, inverse_of: :menu_item_orders

  validates :quantity, :sale_price_cents, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  private

  def set_price
    self.sale_price_cents = 1
  end
  
end
