class Subject < ApplicationRecord
    has_many :pages

    scope :sorted, -> { order('position ASC') }
    scope :visible, -> { where(visible: true) }
    scope :search, -> (query) { where('name LIKE ?', "%#{query}%") }
end
