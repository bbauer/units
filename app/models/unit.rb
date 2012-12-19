class Unit < ActiveRecord::Base
  attr_accessible :description, :price, :promotion, :size, :sqft, :category
end
