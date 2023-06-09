class AdminUser < ApplicationRecord
    # self.table_name = "admin_users" # or rename the class and file names

    # attr_reader :password
    # password=(unencrypted_password)
    # validate_password_of :password, :on => :create
    # validates_presence_of :password_confirmation
    # validates_confirmation_of :password
    # authenticate(unencrypted_password)
    has_secure_password

    has_and_belongs_to_many(:pages)
    has_many(:section_edits)
    has_many(:sections, through: :section_edits)

    def name 
        "#{first_name} #{last_name}"
    end

    EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\z/i
    FORBIDDEN_USERNAMES = ['littlebopeep', 'humptydumpty', 'marymary']

    private
    def username_is_allowed
        if FORBIDDEN_USERNAMES.include?(username)
            errors.add(:username, "has been restricted from use.")
        end
    end

    def no_new_users_on_saturday
        if Time.now.wday == 6
            # errors[:base] << "No new users on Saturday."
            errors.add(:base, "No new users on Saturday.")
        end
    end

    # validates_presence_of(:first_name)
    # validates_length_of(:first_name, maximum: 25)
    # validates_presence_of(:last_name)
    # validates_length_of(:last_name, maximum: 50)
    # validates_presence_of(:username)
    # validates_length_of(:username, within: 8..25)
    # validates_presence_of(:email)
    # validates_uniqueness_of(:username)
    # validates_length_of(:email, maximum: 100)
    # validates_format_of(:email, with: EMAIL_REGEX)
    # validates_confirmation_of(:email)
    validates(
        :first_name,
        :presence => true,
        :length => { :maximum => 25 }
    )
    validates(
        :last_name,
        :presence => true,
        :length => { :maximum => 50 }
    )
    validates(
        :username,
        :length => { :within => 8..25 },</div>
        :uniqueness => true
    )
    validates(
        :email,
        :presence => true,
        :uniqueness => { :case_sensitive => false },
        :length => { :within => 6..100 }
        :format => { :with => EMAIL_REGEX },
        :confirmation => true,
    )
    validate(:username_is_allowed)
    # validate(:no_new_users_on_saturday, on: :create)
end
