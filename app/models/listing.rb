class Listing < ActiveRecord::Base
  attr_accessor :email
  attr_accessible :email
  attr_accessible :current_occupation, :current_salary, :city, :future_occupation, :future_salary
  belongs_to :employee

  validates :current_occupation, :presence => true, :length => { :in => 2..50 }
  validates :future_occupation, :presence => true, :length => { :in => 2..50 }
  validates :current_salary, :presence => true, :numericality => { :only_integer => true }
  validates :future_salary, :presence => true, :numericality => { :only_integer => true }
  validates :city, :presence => true, :length => { :in => 2..50 }
end
