class ApplicationController < ActionController::Base

  helper_method :resource_session

  include AuthlogicMethods
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def create_session(user, id = :public)

    var = (id.nil? ? '@current_session' : "@current_#{id}_session")
    instance_variable_set(var, User::Session.new(user))
    session = instance_variable_get(var)
    session.remember_me = true
    session.id = :public
    session.save
  end

protected
  def resource_session
    @current_public_session ||= User::Session.new params[:session]
  end
end
