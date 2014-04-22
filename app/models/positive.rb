class Positive < ActiveRecord::Base
  belongs_to :item, :class_name => 'Theorem'
  belongs_to :theorem
end
