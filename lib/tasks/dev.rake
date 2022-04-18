task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    Photo.destroy_all
    FollowRequest.destroy_all
    User.destroy_all
  end

  12.times do 
    name = Faker::Name.first_name
    email = Faker::Internet.email
    u = User.create(
      username: name,
      email: email,
      password: "password",
      private: [true, false].sample
      )

    p u.errors.full_messages
    p "#{User.count} users have been created"

  end

  users = User.all
  users.each do | first_user |
    users.each do | second_user |
      if rand < 0.7
          first_user.sent_follow_requests.create(
            recipient: second_user,
            status: FollowRequest.statuses.keys.sample
          )
      end
      
      if rand < 0.7
          second_user.sent_follow_requests.create(
            recipient: first_user,
            status: FollowRequest.statuses.keys.sample
          )
      end

    end
    
  p "#{FollowRequest.count} follow requests have been created"
  end

  users.each do | user |
    rand(10).times do
      photo = user.own_photos.create(
        caption: "#{Faker::Emotion.adjective}", 
        image: "{https://robohash.org/#{rand(999)}"
      )
      
      
    end
  end
end