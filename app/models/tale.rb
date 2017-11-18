class Tale < ApplicationRecord
    has_many :comments, dependent: :destroy
end
