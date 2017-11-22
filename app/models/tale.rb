class Tale < ApplicationRecord
    belongs_to :genre
    has_many :comments, dependent: :destroy
    
    validates :title, length: { minimum: 1 }, presence: true
    validates :body, length: { minimum: 1 }, presence: true
    validates :genre, presence: true

end
