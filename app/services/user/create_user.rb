class User::CreateUser < BaseService
  def initialize
  end

  def call(user, params)
    form = self.form.new(user)
    ActiveRecord::Base.transaction(requires_new: true) do
      if form.validate(params)
        Right.new(form.sync(params)) if form.save
      else
        Left.new(form)
      end
    end
  end

  def form
    User::Form || super
  end

end