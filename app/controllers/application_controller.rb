class ApplicationController < ActionController::Base
  helper_method :current_voter, :current_voter_has_voted?

  def current_voter
    @current_voter ||= Voter.find_by(email: session[:voter_email])
  end

  def current_voter_has_voted?
    current_voter && Vote.exists?(voter: current_voter)
  end
end
