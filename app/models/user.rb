class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :fb_friends, dependent: :destroy
  has_many :songs, dependent: :destroy
  
  before_save :ensure_auth_token

  def self.find_for_oauth_api(params)
    profile = Koala::Facebook::API.new(params[:facebook_token])
    fb_user = profile.get_object("me")
    user_email = fb_user["email"].present? ? fb_user["email"] : "#{fb_user["first_name"].downcase}.#{fb_user["last_name"].downcase}@facebook.com"
    user = User.where(provider: params[:provider], uid: fb_user["id"]).first
    if user
      user
    else
      user = User.where(email: user_email).first
      unless user
        user = User.new(email: user_email, password: Devise.friendly_token[0,20],
        	first_name: fb_user["first_name"], last_name: fb_user["last_name"],
        	name: fb_user["name"], uid: fb_user["id"], provider: params[:provider], image_url: profile.get_picture(fb_user["id"]),
        	date_of_birth: fb_user["birthday"], gender: fb_user["gender"])
        user.save
        Resque.enqueue(FacebookSync, user, params)
        user
      end
    end
    user
  end

  def ensure_auth_token
    if auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end

  def create_fb_friends(graph, friends)
    friends.each do |friend|
      self.fb_friends.create(profile_id: friend["id"], profile_url: friend["link"],
        username: friend["username"].present? ? friend["username"] : friend["link"].split('/')[-1],
        first_name: friend["first_name"], last_name: friend["last_name"], name: friend["name"], gender: friend["gender"],
        email: friend["email"].present? ? friend["email"] : "#{friend["link"].split('/')[-1]}@facebook.com",
        location: (friend["location"]["name"] rescue ""), hometown: (friend["hometown"]["name"] rescue ""),
        birthday: (friend["birthday"] rescue nil),
        image_url: (graph.get_picture(friend["id"]) rescue nil)
      )
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
