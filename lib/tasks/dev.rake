task sample_data: :environment do
  p "Creating sample data"

  if Rails.env.development?
    Like.destroy_all
    Comment.destroy_all
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
    

      user.followers.each do |follower|
        p "User: #{user.id}"
        p "Follower: #{follower.id}"
        
        if (rand < 0.5) && (photo.fans.exclude?(follower))
            photo.fans << follower
        end

        if rand < 0.25
            photo.comments.create(
              body: Faker::Quote.yoda,
              author: follower
            )
        end
      end
    end  
    
  end

  p "#{Photo.count} photos have been created"
  p "#{Comment.count} comments have been created"
  p "#{Like.count} likes have been created"


end