# lib/json_web_token.rb
require 'jwt'  # Add this line to require the JWT library
puts "Loading json_web_token.rb..."

module JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')  # Make sure to specify the algorithm ('HS256' for example)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    nil
  end
end
