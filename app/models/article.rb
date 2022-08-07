class Article < ApplicationRecord    
    validates :title, presence: true, length: {minimal: 6, maximal: 100}
    validates :description, presence: true, length: {minimal: 10, maximal: 300}
end