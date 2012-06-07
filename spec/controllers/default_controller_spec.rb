require 'spec_helper'

describe DefaultController do

  describe "GET 'parse'" do
    it "returns http success" do
      get 'parse'
      response.should be_success
    end
  end

end
