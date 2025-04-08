module Api
  class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      email = params[:email]
      password = params[:password]
      zip_code = params[:zip_code]
      
      voter = Voter.find_by(email: email)
      unless voter
        # Create a new voter with the provided email and zip code
        voter = Voter.new(email: email, zip_code: zip_code)
        # Simply store the password provided, since you only require that something be entered.
        voter.password_hash = password
        unless voter.save
          return render json: { error: "Could not register voter" }, status: :unprocessable_entity
        end
      end

      if voter && voter.authenticate_fake_password?(password) && voter.zip_code.to_s == zip_code.to_s
        session[:voter_email] = voter.email
        render json: { message: "Logged in", voter: voter }, status: :ok
      else
        render json: { error: "Invalid credentials" }, status: :unauthorized
      end
    end

    def destroy
      session.delete(:voter_email)
      render json: { message: "Logged out" }, status: :ok
    end
  end
end