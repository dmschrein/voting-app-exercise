require "rails_helper"

RSpec.describe Candidate, type: :model do
  describe "validations" do
    it "is valid with a unique name" do
      candidate = Candidate.new(name: "Band")
      expect(candidate).to be_valid
    end

    it "is not valid without a name" do
      candidate = Candidate.new(name: nil)
      expect(candidate).not_to be_valid
      expect(candidate.errors[:name]).to include("can't be blank")
    end

    it "is not valid with a duplicate name" do
      Candidate.create!(name: "Band")
      duplicate_candidate = Candidate.new(name: "Band")
      expect(duplicate_candidate).not_to be_valid
      expect(duplicate_candidate.errors[:name]).to include("has already been taken")
    end

    context "candidate count validation" do
      it "is not valid when candidate count reaches the maximum" do
        # Stub Candidate.count to simulate that MAX_CANDIDATES are already created
        allow(Candidate).to receive(:count).and_return(Candidate::MAX_CANDIDATES)
        candidate = Candidate.new(name: "New Candidate")
        expect(candidate).not_to be_valid
        expect(candidate.errors[:base]).to include("Maximum number of #{Candidate::MAX_CANDIDATES} candidates exceeded.")
      end
    end
  end

  describe "default values" do
    it "defaults vote_count to 0 when not explicitly set" do
      candidate = Candidate.create!(name: "Band")
      expect(candidate.vote_count).to eq(0)
    end
  end
end