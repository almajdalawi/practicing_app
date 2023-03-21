class Subject < ApplicationRecord
    has_many(:pages)

    # validates_presence_of(:name)
    # validates_length_of(:name, maximum: 255)
    validates(
        :name,
        :presence => true,
        :length => { :maximum => 255 }
    )

    scope :sorted, -> { order('position ASC') }
    scope :visible, -> { where(visible: true) }
    scope :search, -> (query) { where('name LIKE ?', "%#{query}%") }
end
