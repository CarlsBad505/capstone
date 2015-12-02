require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    it "should have an http response of success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
end
