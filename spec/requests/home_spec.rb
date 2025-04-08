require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET /index" do
    it "renders successfully" do
      get root_path
      expect(response).to be_successful
      # Check for a string that exists in the response, such as the mount point or title
      expect(response.body).to include('<div id="root"></div>')
    end
  end
end