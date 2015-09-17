FactoryGirl.define do 
	factory :post do 
		title "Post title"
		body "Post bodies must be pretty long"
		user
		topic { Topic.create(name: 'Topic name')}
	end

end