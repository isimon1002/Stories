class Tale < ApplicationRecord
    belongs_to :genre
    has_many :comments, dependent: :destroy

    validates :title, length: { minimum: 1 }, presence: true

end
