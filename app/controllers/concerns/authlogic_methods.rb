module AuthlogicMethods
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :current_session
  end

protected

  def current_session(id = :public)
    if User.session_ids.include?(id)
      var = (id.nil? ? '@current_session' : "@current_#{id}_session")
      return instance_variable_get(var) if instance_variable_defined?(var)
      return instance_variable_set(var, User::Session.find(id))
    else
      return nil
    end
  end

  def current_user(id = :public)
    if User.session_ids.include?(id)
      var = (id.nil? ? '@current_user' : "@current_#{id}_user")
      return instance_variable_get(var) if instance_variable_defined?(var)

      instance_variable_set(var, (current_session(id) && current_session(id).record).try(:decorate))
    else
      return nil
    end
  end

  def reset_current_session(id = :public)
    var = (id.nil? ? '@current_session' : "@current_#{id}_session")
    instance_variable_defined?(var) ? remove_instance_variable(var) : true
  end

  def reset_current_user(id = :public)
    var = (id.nil? ? '@current_user' : "@current_#{id}_user")
    instance_variable_defined?(var) ? remove_instance_variable(var) : true
  end

  def reset_authlogic(id = :public)
    reset_current_session(id)
    reset_current_user(id)
  end

  def require_user
    unless current_user.present?
      respond_to do |format|
        format.html do
          redirect_to(auth_sign_in_url) and return false
        end
        format.json do
          render(json: { message: 'Forbidden', code: 403 }.to_json, status: 403) and return false
        end
      end
    end

    true
  end

  def require_no_user
    # redirect_to(root_url) and return false unless current_user.guest?
    redirect_to(root_url) and return false if current_user.present?

    true
  end
end