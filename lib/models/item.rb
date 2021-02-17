class Item < ActiveRecord::Base
    has_many :orders
    has_many :sorcerers, through: :orders
end