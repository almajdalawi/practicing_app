class Section < ApplicationRecord
    has_many :section_edits
    has_many :editors, through: 'section_edits', class_name: 'AdminUser'
    belongs_to :page

    scope :sorted, -> { order(position: :asc) }
    scope :visible, -> { where(visible: true) }
    scope :search, -> (query) { where('name LIKE ?', "%#{query}%") }

    CONTENT_TYPES = ['Tech', 'Engineering', 'Science', 'Math', 'History', 'Geography', 'Literature', 'Philosophy', 'Psychology', 'Sociology', 'Politics', 'Economics', 'Law', 'Religion', 'Art', 'Music', 'Dance', 'Theater', 'Film', 'Photography', 'Architecture', 'Fashion', 'Food', 'Sports', 'Gaming', 'Other']

end
