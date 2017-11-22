class Tale < ApplicationRecord
    belongs_to :genre
    has_many :comments, dependent: :destroy
    
    after_validation :validate_body
    
    validates :title, length: { minimum: 1 }, presence: true
    
    
    def validate_body
        if body.count(" ") < 3 
         return error
        end
    end

end
