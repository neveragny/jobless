class Employee < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :needs_password
  # attr_accessible :title, :body

  has_many :listings, :dependent => :destroy
  has_many :messages, :dependent => :destroy

  def unread_messages
    messages.where("read = ?", true)
  end
end
