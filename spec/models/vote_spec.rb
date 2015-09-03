describe Vote do 
	describe "validations" do 
		describe "value validations" do 
			it "only allows -1 or 1 as values" do
				one = Vote.create(valid: 1)
				expect(one.valid?) eql(true)

				minus_one = Vote.create(valid: -1)
				minus_one.should be_true

				two = Vote.create(valid: 2)
				expect(two.valid?) eql(false)
			end
		end
	end
	
end