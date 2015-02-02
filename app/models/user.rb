class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :ensure_auth_token

  def self.find_for_oauth_api(params)
  	if params[:email].present?
  	  user_email = params[:email]
  	elsif params[:link].present?
  	  user_email = "#{params[:link].split('/')[-1]}@facebook.com}"
  	else
  	  user_email = "#{params[:first_name].downcase}.#{params[:last_name].downcase}@facebook.com"
  	end
    user = User.where(provider: params[:provider], uid: params[:uid]).first
    if user
      user
    else
      user = User.where(email: user_email).first
      unless user
        user = User.new(email: user_email, password: Devise.friendly_token[0,20],
        	first_name: params[:first_name], last_name: params[:last_name],
        	name: params[:name], uid: params[:uid], provider: params[:provider], image_url: params[:image_url],
        	date_of_birth: params[:date_of_birth], gender: params[:gender])
        user.save
      end
    end
    user
  end

  def ensure_auth_token
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end
 
  private
  
  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end

end
