require 'spec_helper'

describe DefaultController do

  describe "GET 'parse'" do
    it "returns http success" do
      get 'parse'
      response.should be_success
    end
  end

  describe "GET 'parse_date'" do
    render_views

    it "returns a valid date" do

      date = "tomorrow"

      get 'parse', {q: date}

      body = JSON(response.body)

      p body

      body["q"].should == date

      body["valid"].should        be_true
      body["utc"].should_not      be_empty
      body["local"].should_not    be_empty
      body["offset"].should_not   be_nil
      body["timezone"].should_not be_empty

      response.should be_success
    end
  end
end
