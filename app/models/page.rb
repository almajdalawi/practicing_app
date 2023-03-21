class Page < ApplicationRecord
    belongs_to(:subject)
    has_and_belongs_to_many(:editors, class_name: "AdminUser")
    has_many(:sections)

    # validates_presence_of(:name)
    # validates_length_of(:name, maximum: 255)
    # validates_presence_of(:permalink)
    # validates_length_of(:permalink, within: 3..255)
    # validates_uniqueness_of(:permalink)
    validates(
        :name,
        :presence => true,
        :length => { :maximum => 255 }
    )
    validates(
        :permalink,
        :presence => true,
        :length => { :within => 3..255 },
        :uniqueness => true
    )

    scope :sorted, -> {order('position ASC')}
    scope :visible, -> {where(visible: true)}
    scope :search, -> (query) {where('name LIKE ?', "%#{query}%")}
end
