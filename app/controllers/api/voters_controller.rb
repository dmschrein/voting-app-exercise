module Api
  class VotersController < ApplicationController
    # POST /voters
    # This endpoint handles both creating a new voter (if they don't exist)
    # and logging in an existing voter.
    def create
      # Find an existing voter by email or initialize a new one.
      @voter = Voter.find_or_initialize_by(email: voter_params[:email])
      @voter.assign_attributes(voter_params)
      
      # If the voter record already exists in the database...
      if @voter.persisted?
        # Log the voter in (if not already logged in).
        login_voter(@voter) unless current_voter == @voter
        
        # Check if the voter has already voted.
        if current_voter_has_voted?
          render json: { 
            message: "You have already voted!", 
            voter: @voter,
            redirect_url: votes_url
          }, status: :ok
        else
          render json: { 
            message: "Welcome! Cast your vote!", 
            voter: @voter,
            redirect_url: new_vote_url
          }, status: :ok
        end
      else
        # If the record is not yet persisted, save it.
        if @voter.save
          login_voter(@voter)
          render json: { 
            message: "Voter created successfully.", 
            voter: @voter,
            redirect_url: new_vote_url
          }, status: :created, location: @voter
        else
          render json: @voter.errors, status: :unprocessable_entity
        end
      end
    end

    # GET /voters/:id
    def show
      @voter = Voter.find(params[:id])
      render json: @voter
    end

    private

    def voter_params
      params.require(:voter).permit(:name, :email, :password_hash, :zip_code)
    end
  end
end