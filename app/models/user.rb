class User < ApplicationRecord
    validates :username, :email, presence: true, uniqueness: true
    has_secure_password
  #   before_save :ensure_password_confirmation


  # private

  # def ensure_password_confirmation
  #   unless password_confirmation.nil? || password == password_confirmation
  #     errors.add(:password_confirmation, "doesn't match Password")
  #     throw :abort
  #   end
  # end
end