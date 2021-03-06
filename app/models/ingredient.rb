class Ingredient < ApplicationRecord
  belongs_to :chef, class_name: 'User', foreign_key: :user_id
  has_many :ingredients_menu_items, inverse_of: :ingredient
  has_many :menu_items, through: :ingredients_menu_items, inverse_of: :ingredients
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user_id
end
