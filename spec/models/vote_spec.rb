require 'rails_helper'

describe Vote  do 
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
end