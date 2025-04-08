module Api
  class CandidatesController < ApplicationController
    before_action :require_login
    skip_before_action :verify_authenticity_token

    # POST /api/candidates
    def create
      if current_voter_has_voted?
        return render json: { error: "You have already voted!" }, status: :forbidden
      end

      max_candidates = Candidate::MAX_CANDIDATES
      write_in_candidate = nil
      vote = nil

      ActiveRecord::Base.transaction do
        write_in_candidate = Candidate.new(candidate_params)
        # Override the default: set the candidate's votes to 1 for a write-in
        write_in_candidate.vote_count = 1
        unless write_in_candidate.save
          raise ActiveRecord::Rollback
        end

        vote = Vote.new(candidate: write_in_candidate, voter: current_voter)
        unless vote.save
          raise ActiveRecord::Rollback
        end
      end

      if write_in_candidate.persisted? && vote.persisted?
        render json: { 
          message: "Your vote has been successfully recorded!",
          vote: vote,
          candidate: write_in_candidate,
          max_candidates: max_candidates
        }, status: :created
      else
        render json: { 
          errors: {
            candidate: write_in_candidate&.errors&.full_messages,
            vote: vote&.errors&.full_messages
          },
          candidates: Candidate.all,
          max_candidates: max_candidates
        }, status: :unprocessable_entity
      end
    end

    private

    def candidate_params
      params.require(:candidate).permit(:name)
    end

    def require_login
      if current_voter.blank?
        render json: { error: "Please sign in to continue." }, status: :unauthorized
      end
    end
  end
end