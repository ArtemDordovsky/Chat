require 'spec_helper'

describe User do
  context 'with valid attributes' do
    it "is valid" do
      user = User.new(email: "email@email", password: "321321")
      user.should be_valid
    end
    it "is not valid without email" do
      user = User.new(email: nil, password: "321321")
      user.should_not be_valid
    end
    it "is not valid without password" do
      user = User.new(email: "email@email", password: nil)
      user.should_not be_valid
    end
  end
  context 'authenticate' do
    user = User.create(email: "email1@email", password: "321321")
    it {User.authenticate(user.email, user.password).should be_true}
    it {User.authenticate("fake@fake", "fake").should_not be_true}
  end
end
