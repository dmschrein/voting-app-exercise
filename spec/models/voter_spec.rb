require "rails_helper"

RSpec.describe Voter, type: :model do
  it "saves a valid voter" do
    voter = Voter.new(email: "test@example.com", zip_code: "12345", password_hash: "secret")
    expect(voter.save).to be true
  end

  it "is invalid without an email" do
    voter = Voter.new(zip_code: "12345", password_hash: "secret")
    expect(voter.save).to be false
  end
end