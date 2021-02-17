class Order < ActiveRecord::Base
    belongs_to :sorcerer
    belongs_to :item
end