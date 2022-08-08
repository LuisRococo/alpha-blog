class Article < ApplicationRecord    
    validates :title, presence: true, length: {minimum: 6, maximal: 100}
    validates :description, presence: true, length: {minimum: 10, maximal: 300}
end