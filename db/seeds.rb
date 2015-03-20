require 'faker'

5.times do
  User.create(:username => Faker::Name.first_name, :email => Faker::Internet.email, :password => Faker::Lorem.word)
end

#test user
User.create(:username => "test_user", :email => "test@gmail.com", :password => "pass")
10.times do
  Survey.create(:title => Faker::Company.bs, :user_id => User.all.sample.id)
end

40.times do
  Question.create(:question_text => Faker::Company.catch_phrase, :survey_id => Survey.all.sample.id)
end

100.times do
  Choice.create(:choice_text => Faker::Commerce.product_name, :choice_frequency => Random.rand(10) + 1, :question_id => Question.all.sample.id)
end
