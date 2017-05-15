class User < ActiveRecord::Base
#constants
  if Rails.env.production?
    MIN_PASSWORD_LENGTH = 6
  else
    MIN_PASSWORD_LENGTH = 8
  end
#associations

#scopes

#acts
  acts_as_authentic do |c|
    c.merge_validates_uniqueness_of_email_field_options :case_sensitive => false
    c.merge_validates_length_of_password_field_options :minimum => MIN_PASSWORD_LENGTH
    c.validate_login_field = false
    c.session_ids = [:public]
    c.logged_in_timeout = 2.minutes
    c.ignore_blank_passwords = false

    c.crypto_provider = Authlogic::CryptoProviders::SCrypt
  end

#callbacks
  before_validation :generate_password, on: :create

#class methods

  def self.find_by_lowercase_email_or_login(login)
    self.where(arel_table[:login].lower.eq(login.downcase).or(arel_table[:email].lower.eq(login.downcase))).first
  end

  def self.find_by_lowercase_email_or_login!(login)
    self.where(arel_table[:login].lower.eq(login.downcase).or(arel_table[:email].lower.eq(login.downcase))).first
  end

#public methods
  def set_password(password, password_confirmation)
    self.password = password
    self.password_confirmation = password_confirmation
  end

#protected methods
protected
  def reset_password_token!
    self.password_token = SecureRandom.hex(10)
    save(validate: false)
  end

  def generate_password
    return if password.present?

    password = SecureRandom.hex(10)
    set_password(password, password)

    password
  end
#private methods

end