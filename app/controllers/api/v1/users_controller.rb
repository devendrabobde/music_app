class Api::V1::UsersController < ApplicationController
  respond_to :json
  
  def login
  	if params[:provider] == 'facebook'
      user = User.find_for_oauth_api(params) rescue nil
    elsif params[:auth_token].present?
      user = User.find_by_auth_token(params[:auth_token])
    else
      render json: { status: 401, message: "Please choose a Valid Provider" } and return
    end

    if user
      sign_in("user", user)
      render json: { status: 200, message: "Signed in successfully.", auth_token: user.auth_token, user: user.as_json }
    else
      render json: { status: 401, message: "Please Sign in." }
    end
  end

  def logout
  	resource = User.find_by_auth_token(params[:auth_token])
    if resource.auth_token == params[:auth_token]
      resource.auth_token = nil
      resource.save
      render json: { status: 200, message: "You are signed out successfully" }
    else
      render json: { status: 401, message: "Invalid authentication token." }
    end
  end

  def post_songs
    user = User.find_by_id(params[:user_id])
    if user
      params[:songs].each do |song|
        user.songs.create(name: song)
      end
      render json: { status: 200, message: "Songs saved successfully" }
    else
      render json: { status: 401, message: "User not found" }
    end
  end

  def get_songs
    user = User.find_by_id(params[:user_id])
    if user
      songs = user.songs.present? ? user.songs : []
      render json: { status: 200, message: "Songs Found", songs: songs }
    else
      render json: { status: 401, message: "User not found" }
    end
  end

end