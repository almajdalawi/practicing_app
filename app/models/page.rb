class Page < ApplicationRecord
    belongs_to :subject
    has_and_belongs_to_many :editors, class_name: "AdminUser"
    has_many :sections

    scope :sorted, -> {order('position ASC')}
    scope :visible, -> {where(visible: true)}
    scope :search, -> (query) {where('name LIKE ?', "%#{query}%")}
end
