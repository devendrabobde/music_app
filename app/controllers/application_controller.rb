class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  
  # before_filter :authenticate_user_from_token!

  private
  
    def authenticate_user_from_token!
      user_email = params[:email].presence
      user       = user_email && User.find_by_email(user_email)
      if user && Devise.secure_compare(user.auth_token, params[:auth_token])
        # sign_in user, store: false
        @user = user
      end
    end

end