10.times do 
  User.create(
    username: Faker::Internet.user_name, 
    email: Faker::Internet.email, 
    password: Faker::Internet.password(8,15),
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    affiliation: Faker::Educator.university)
end

10.times do
	Topic.create(
		name: Faker::Space.galaxy)
end

counter = 1
Topic.all.each do |topic|
  topic.article_id = counter
  topic.save
  counter += 1
end

20.times do
	Article.create(
		title: Faker::Book.title,
		author_id: Faker::Number.between(1, 29),
		topic_id: Faker::Number.between(1, 10))
end

40.times do
	Comment.create(
		content: Faker::Lorem.sentences,
		user_id: Faker::Number.between(1, 25),
		article_id: Faker::Number.between(1, 42))
end