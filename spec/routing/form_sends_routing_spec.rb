require "rails_helper"

RSpec.describe FormSendsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/form_sends").to route_to("form_sends#index")
    end

    it "routes to #show" do
      expect(get: "/form_sends/1").to route_to("form_sends#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/form_sends").to route_to("form_sends#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/form_sends/1").to route_to("form_sends#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/form_sends/1").to route_to("form_sends#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/form_sends/1").to route_to("form_sends#destroy", id: "1")
    end
  end
end
