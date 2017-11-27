class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :tale
  
  after_save :update_tale
  
  validates :value, inclusion: { in: [-1, 1], message: "%{value} is not a valid vote." }, presence: true
  
  private
 
  def update_tale
     tale.update_rank
  end
end
