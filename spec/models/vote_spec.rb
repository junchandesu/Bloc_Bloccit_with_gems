require 'rails_helper'

describe Vote  do 

	include TestFactories
	
	describe "value validation" do

			it "only allows -1 or 1 as values" do
				two = Vote.new(value: 2)
				expect(two.valid?).to be_falsey			
			end

			it "allows 1 as value" do
				one = Vote.new(value: 1)
				expect(one.valid?).to be true
			end
		end
	describe 'after_save' do
		it "calls 'Post#update_rank' after_save" do
			post = associated_post
			vote = Vote.new(value: 1, post: post)
			expect(post).to receive(:update_rank)
			vote.save
		end
	end
end



