# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

%w[BlackLivesMatter AllLivesMatter Inequality Oppression Privilege Racism Camels Conn ConnecticutCollege NewLondon StudentLife FacultyLife \ 
StaffLife Student Staff Faculty Minority PersonOfColor MinorityGroup BIPOC QTBIPOC].each do |tag|
	Tag.create(name:tag)
end

10.times {
	User.create(
		first_name: Faker::Name,
		last_name: Faker::Name,
		email: Faker::Internet.unique.free_email,
		username: Faker::Internet.unique.username,
		password: Faker::Internet.password(min_length: 10, max_length: 20),
		image_url: Faker::Avatar.image(size: "50x50"),
		role: Faker::Number.within(range: 1..3),
		bio: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
		affiliation: Faker::Number.within(range: 0..6)
	)
}

tag_count = Tag.count;

50.times {
	post = Post.create(
		title: Faker::Lorem.sentence,
		body: Faker::Lorem.paragraphs(number: 5),
		approved: Faker::Boolean.boolean,
		user_id: Faker::Number.within(range: 0..10),
		anonymous: Faker::Boolean.boolean,
		approves: Faker::Number.within(range: 0..10),
		disapproves: Faker::Number.within(range: 0..5),
		public: Faker::Boolean.boolean
	)
	Faker::Number.within(range: 0..5).times {
		Tagging.create(post_id:post.id,tag_id:Faker::Number.within(range: 0..tag_count))
	}
	Faker::Number.within(range: 0..5).times {
		Comment.create(
			user_id: Faker::Number.within(range: 0..10),
			body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
			commentable_id: post.id,
			commentable_type: "Post"
		)
		comment_count = Comment.count;
		Comment.create(
			user_id: Faker::Number.within(range: 0..10),
			body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
			commentable_id: Faker::Number.within(range: 0..tag_count)),
			commentable_type: "Comment"
		)
	}
}

50.times {
	Like.create(
		user_id: Faker::Number.within(range: 0..10),
		post_id: Faker::Number.within(range: 0..50),
	)
}
	
