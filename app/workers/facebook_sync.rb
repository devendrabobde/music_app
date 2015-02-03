class FacebookSync
  @queue = :droplets

  def self.perform(user, params)
    @graph  = Koala::Facebook::API.new(params[:facebook_token])
    friends = @graph.get_connections("me", "friends", fields: "name, gender, first_name, last_name, location, hometown, birthday, link") rescue []
    user.create_fb_friends(@graph, friends) unless friends.blank?
  end

end