require 'rails_helper'
require 'spec_helper'

RSpec.describe User, :type => :model do

  # before do
  #     # Sign in as a user.
  #     sign_in_as_a_valid_user
  # end

  it "orders by last name" do
    # sign_in_as_a_valid_user
    lindeman = User.create!(email: "Lindeman@test.com", password: "password")
    chelimskyy = User.create!(email: "Chelimskyy@test.com", password: "password")

    # expect(User.ordered_by_last_name).to eq([chelimsky, lindeman])
  end
end
# 