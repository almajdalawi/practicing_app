class Section < ApplicationRecord
    has_many(:section_edits)
    has_many(:editors, through: 'section_edits', class_name: 'AdminUser')
    belongs_to(:page)

    CONTENT_TYPES = ['Tech', 'Engineering', 'Science', 'Math', 'History', 'Geography', 'Literature', 'Philosophy', 'Psychology', 'Sociology', 'Politics', 'Economics', 'Law', 'Religion', 'Art', 'Music', 'Dance', 'Theater', 'Film', 'Photography', 'Architecture', 'Fashion', 'Food', 'Sports', 'Gaming', 'Other']

    # validates_presence_of(:name)
    # validates_length_of(:name, maximum: 255)
    validates(
        :name,
        :presence => true,
        :length => { :maximum => 255 }
    )
    validates_inclusion_of(:content_type, in: CONTENT_TYPES, message: 'must be one of: #{CONTENT_TYPES.join(", ")}')
    validates_presence_of(:content)

    scope :sorted, -> { order(position: :asc) }
    scope :visible, -> { where(visible: true) }
    scope :search, -> (query) { where('name LIKE ?', "%#{query}%") }
end
