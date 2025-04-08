module Api
  class VotesController < ApplicationController
    skip_before_action :verify_authenticity_token

    # GET /votes
    def index
      @votes = Vote.all
      render json: votes
    end

    # GET /votes/new
    # This action supplies any initial data your React form might need.
    def new
      if current_voter.blank?
        return render json: { error: "Please sign in to vote!" }, status: :unauthorized
      end

      if current_voter_has_voted?
        return render json: { error: "You have already voted. Thanks for your participation!" }, status: :forbidden
      end

      data = {
        candidates: Candidate.all,
        write_in_candidate: Candidate.new,  # returns an empty Candidate object
        max_candidates: Candidate::MAX_CANDIDATES,
        vote: Vote.new
      }
      render json: data
    end

    # POST /votes
    def create
      if current_voter.blank?
        return render json: { error: "Please sign in to vote!" }, status: :unauthorized
      end

      candidate_id = vote_params[:candidate_id]
      candidate = Candidate.find_by(id: candidate_id)

      unless candidate
        return render json: { error: "Candidate not found." }, status: :unprocessable_entity
      end

      # Increment existing candidate's vote_count
      candidate.increment!(:vote_count)

      # Create the Vote row
      @vote = Vote.new(vote_params.merge(voter: current_voter))
      if @vote.save
        render json: {
          message: "Vote recorded!",
          vote: @vote,
          candidate: candidate
        }, status: :created
      else
        # Return the errors along with any supporting data the form might need
        data = {
          candidates: Candidate.all,
          write_in_candidate: Candidate.new,
          errors: @vote.errors.full_messages
        }
        render json: data, status: :unprocessable_entity
      end
    end

    # GET /votes/:id
    def show
      if current_voter.blank?
        return render json: { error: "Please sign in" }, status: :unauthorized
      end

      vote = Vote.find_by(id: params[:id], voter_id: current_voter.id)
      if vote
        render json: vote
      else
        render json: { error: "Vote not found or you're not authorized to view that vote." }, status: :not_found
      end
    end

    private

    def vote_params
      params.require(:vote).permit(:candidate_id)
    end
  end
end