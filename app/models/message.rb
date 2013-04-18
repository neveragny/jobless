class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Message < ActiveRecord::Base
  belongs_to :employee

  attr_accessible :from_email, :body, :read

  validates :from_email, :presence => true, :email => true
  validates :body, :presence => true, :length => { :in => 2..1000 }
  validates :read, :presence => true

end
