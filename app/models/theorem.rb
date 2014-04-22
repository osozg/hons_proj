class Theorem < ActiveRecord::Base
  default_scope { order('place ASC') }

  has_many :positives, :foreign_key => 'item_id'
  has_many :theorems, :through => :positives
end
