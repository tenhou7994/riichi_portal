class User::Form < Reform::Form
  property :login
  property :email
  property :first_name
  property :last_name
  property :password
  property :password_confirmation

  validation :default do
    required(:email).filled(unique?: :email)
    required(:login).filled
    required(:password).filled
    required(:password_confirmation).filled
  end
end