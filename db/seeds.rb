# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

israel = {
  fb_messenger_id: "1249671568407617",
  fb_profile_id: "332335830458707",
  picture_url: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12096030_100829086942717_8527138496669322222_n.jpg?oh=a065de481cf012d08f9ee8e991d00373&oe=58B20170",
  first_name: "Israel",
  full_name: "Israel Madueme",
}

ashely = {
  fb_messenger_id: "1394801870531711",
  fb_profile_id: "10154276433464531",
  picture_url: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12813976_10153621234204531_5170130368261047714_n.jpg?oh=42bad2ec64421686180cf2728aa43de8&oe=58B3E5D8",
  first_name: "Ashley",
  full_name: "Ashley Wong",
}

jeanine = {
  fb_messenger_id: "1246256218780554",
  fb_profile_id: "196377360819352",
  picture_url: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/15338815_211470649310023_8742677445102530523_n.jpg?oh=725002d9093448932ab07d53e191bab3&oe=58C6B6B5",
  first_name: "Jeanine",
  full_name: "Jeanine Huang",
}

# Create users
israel = User.create israel
ashely = User.create ashely
jeanine = User.create jeanine

# Create friendships
Friendship.create({user_id: israel.id, friend_id: jeanine.id})
Friendship.create({user_id: israel.id, friend_id: ashely.id})
Friendship.create({user_id: ashely.id, friend_id: israel.id})
Friendship.create({user_id: ashely.id, friend_id: jeanine.id})
Friendship.create({user_id: jeanine.id, friend_id: israel.id})
Friendship.create({user_id: jeanine.id, friend_id: ashely.id})

