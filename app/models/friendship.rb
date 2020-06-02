class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.check_db(email)
    where(email: email).first
  end
end
