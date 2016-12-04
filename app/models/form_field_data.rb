class FormFieldData

  EXERCISE = [
    'Run/Jog', 'Lift', 'Hit the Gym', 'Basketball',
    'Soccer', 'Swimming', 'Baseball', 'Water Sports', 'Walking',
    'Volleyball', 'Tennis', 'Racket Sports', 'Snow Sports',
    'Cycling', 'Skating', 'Martial Arts', 'Gymnastics',
    'Yoga', 'Hiking'
  ].sort.append('Other Exercise')

  HANGOUT = [
    'Eating Together', 'Grocery Shopping', 'Cooking',
    'Studying', 'Volunteering', 'Video Games', 'Table Top Games', 'Shopping',
    'Watch a Movie', 'City Events', 'Spiritual Events', 'Outdoor Activities'
  ].sort.append('Other Hangout Activity')

  ONCAMPUS = [
    'Therapets', 'Mindfulness Room', 'Group X', 'TedxCMU'
  ].sort.append('Other Campus Event')

  ACTIVITIES = EXERCISE + HANGOUT + ONCAMPUS

  FREE_DAYS = [
    'Any Day', 'Any Weekday', 'Weekend', 'Sunday',
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday'
  ]

  FREE_TIMES = [
    'Any Time', 'Really Early', 'In the morning', 'In the afternoon', 'In the evening', 'At night'
  ] + (1..24).map{|hour| "At #{Time.parse("#{hour}:00").strftime("%l:00 %P")}"}

end

