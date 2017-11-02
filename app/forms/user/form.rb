class User::Form < Reform::Form
  property :login
  property :email
  property :first_name
  property :last_name
  property :password
  property :password_confirmation

  validation :default do
    configure do
      option :record
      def unique?(attr_name, value)
        record.class.where.not(id: record.id).where(attr_name => value).empty?
      end
    end
    required(:email).filled(unique?: :email)
    required(:login).filled
    required(:password).filled
    required(:password_confirmation).filled
  end
end