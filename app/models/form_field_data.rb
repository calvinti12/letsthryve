class FormFieldData

  EXERCISE = [
    'Running', 'Lifting', 'Going to the Gym', 'Basketball',
    'Soccer', 'Swimming', 'Baseball', 'Water Sports', 'Walking',
    'Volleyball', 'Tennis', 'Racket Sports', 'Snow Sports',
    'Cycling', 'Skating', 'Martial Arts', 'Gymnastics',
    'Yoga', 'Hiking', 'Other Exercise'
  ]

  HANGOUT = [
    'Eating Together', 'Grocery Shopping', 'Cooking', 'Just Hanging Out',
    'Studying', 'Volunteering', 'Video Games', 'Table Top Games', 'Shopping',
    'Watch a Movie', 'City Events', 'Spiritual Events', 'Outdoor Activities'
  ]

  ONCAMPUS = [
    'Therapets', 'Mindfulness Room', 'Group X', 'Other Campus Event'
  ]

  FREE_DAYS = [
    'Any Day', 'Any Weekday', 'Weekend', 'Sunday',
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday'
  ]

  FREE_TIMES = [
    'Any Time', 'Really Early', 'In the morning', 'In the afternoon', 'In the evening', 'At night'
  ] + (1..24).map{|hour| "At #{Time.parse("#{hour}:00").strftime("%l%P")}"}

  EXACT_MONTHS = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ]

  EXACT_DAYS = (1..31).to_a

  EXACT_TIMES = (1..24).map{|hour| "#{Time.parse("#{hour}:00").strftime("%l%P")}"}
end

