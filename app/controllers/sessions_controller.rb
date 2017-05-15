class SessionsController < ApplicationController
  skip_filter :require_user, except: [:destroy]
  before_filter :require_no_user, only: [:new, :create]

  helper_method :resource_session

  # def new
  #   render 'auth/sessions/new.xhr', :layout => false if request.xhr?
  # end

  def create
    if create_session(params[:session])
      self.reset_authlogic

      flash[:notice] = "Welcome back #{current_user.contact.display_name}"

      url = if session[:return_to].present?
        session[:return_to]
      else
        root_url
      end

      respond_to do |format|
        format.html { redirect_to url }
        format.js {
          render partial: 'shared/js/redirect', locals: { url: url }
        }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js {
          render partial: 'shared/js/content', locals: {
            replace: '@authForm',
            with: 'auth/sessions/shared/form',
            locals: {
              :session => resource_session,
              :remote => true
            }
          }
        }
      end
    end
  end

  def destroy
    User::Session.find(:public).destroy
    session[:return_to] = nil

    redirect_to root_url
  end

protected

  def resource_session
    @current_public_session ||= User::Session.new params[:session]
  end
end