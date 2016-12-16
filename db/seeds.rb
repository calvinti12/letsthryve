# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

israel = {
  fb_messenger_id: "1249671568407617",
  picture_url: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12096030_100829086942717_8527138496669322222_n.jpg?oh=a065de481cf012d08f9ee8e991d00373&oe=58B20170",
  first_name: "Israel",
  full_name: "Israel Madueme",
}

ashely = {
  fb_messenger_id: "1394801870531711",
  picture_url: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/12813976_10153621234204531_5170130368261047714_n.jpg?oh=42bad2ec64421686180cf2728aa43de8&oe=58B3E5D8",
  first_name: "Ashley",
  full_name: "Ashley Wong",
}

jeanine = {
  fb_messenger_id: "1246256218780554",
  picture_url: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/15338815_211470649310023_8742677445102530523_n.jpg?oh=725002d9093448932ab07d53e191bab3&oe=58C6B6B5",
  first_name: "Jeanine",
  full_name: "Jeanine Huang",
}

nikita = {
  picture_url: "https://scontent-atl3-1.xx.fbcdn.net/v/t1.0-1/p160x160/15220114_10211266959890388_547915919189966138_n.jpg?oh=6b73cd83c356beffeb96d2534b2fdae1&oe=58F83E63",
  first_name: "Nikita",
  full_name: "Nikita Bokil",
}

renzo = {
  picture_url: "https://scontent-atl3-1.xx.fbcdn.net/v/t1.0-1/c36.0.160.160/p160x160/12360157_10153759512262380_7448695663472232283_n.jpg?oh=f1fb6b18b55cfcd2789d69cb71735fb8&oe=58F0BB4C",
  first_name: "Renzo",
  full_name: "Renzo Bautista ",
}

hanson = {
  picture_url: "https://scontent-atl3-1.xx.fbcdn.net/v/t1.0-1/p160x160/12923344_1166766580022458_1493336177519295152_n.jpg?oh=d44217730f303b89e473edc90874b865&oe=58F0745F",
  first_name: "Hanson",
  full_name: "Hanson Zeng",
}

jen = {
  picture_url: "https://scontent-atl3-1.xx.fbcdn.net/v/t1.0-1/c0.0.160.160/p160x160/1928337_1017044978316719_2759336424760058839_n.jpg?oh=689b329195cf616939f071c9d46d51c6&oe=58AE6651",
  first_name: "Jennifer",
  full_name: "Jennifer Han",
}

# Create users
israel = User.create israel
ashely = User.create ashely
jeanine = User.create jeanine
nikita = User.create nikita
renzo = User.create renzo
hanson = User.create hanson
jen = User.create jen

group1 = [jeanine, nikita, renzo, jen]
group2 = [ashely, renzo, hanson, jen]

# Create friendships

group1.each do |person|
  group1.each do |other|
    unless person.id == other.id
      Friendship.create({user_id: person.id, friend_id: other.id})
    end
  end
end

group2.each do |person|
  group2.each do |other|
    unless person.id == other.id
      Friendship.create({user_id: person.id, friend_id: other.id})
    end
  end
end

Friendship.create({user_id: israel.id, friend_id: jeanine.id})
Friendship.create({user_id: israel.id, friend_id: ashely.id})
Friendship.create({user_id: ashely.id, friend_id: israel.id})
Friendship.create({user_id: ashely.id, friend_id: jeanine.id})
Friendship.create({user_id: jeanine.id, friend_id: israel.id})
Friendship.create({user_id: jeanine.id, friend_id: ashely.id})
