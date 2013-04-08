class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  
  has_secure_password
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }

  has_many :microposts, dependent: :destroy

  # migrations ########################
  # t.string :name
  # t.string :email
  #
  # add_column :users, :password_digest, :string
  # add_column :users, :remember_token, :string
  #
  # add_index :users, :email, unique: true
  # add_index  :users, :remember_token
  # t.timestamps
  ######################################
  
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
