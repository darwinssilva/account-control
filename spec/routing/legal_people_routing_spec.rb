require "rails_helper"

RSpec.describe LegalPeopleController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/legal_people").to route_to("legal_people#index")
    end

    it "routes to #show" do
      expect(:get => "/legal_people/1").to route_to("legal_people#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/legal_people").to route_to("legal_people#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/legal_people/1").to route_to("legal_people#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/legal_people/1").to route_to("legal_people#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/legal_people/1").to route_to("legal_people#destroy", :id => "1")
    end
  end
end
