require 'rails_helper'


describe "Visiting profiles" do

include Warden::Test::Helpers
Warden.test_mode!
include TestFactories

    before do
        @user = authenticated_user
        @post = associated_post(user: @user)
        @comment = Comment.create(user: @user, post: @post, body: "A Comment.")
        allow(@comment).to receive(:send_favorite_emails)
        @comment.save
    end

    describe "not signed in" do

        it "shows profiles" do 
        visit user_path(@user)
        expect(current_path).to eq(user_path(@user))
        expect( page ).to have_content(@user.name)
      # expect( page ).to have_content(@post.title)
        expect( page ).to have_content(@comment.body)

        end
    end



    describe "signed in" do

        before do

            login_as @user, role: 'admin', scope: @user

        end

        it "shows profiles" do
        visit user_path(@user)
        expect(current_path).to eq(user_path(@user))
        expect( page ).to have_content(@user.name)
      # expect( page ).to have_content(@post.title)
        expect( page ).to have_content(@comment.body)
        end


    end
end