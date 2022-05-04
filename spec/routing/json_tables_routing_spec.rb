require "rails_helper"

RSpec.describe JsonTablesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/json_tables").to route_to("json_tables#index")
    end

    it "routes to #show" do
      expect(get: "/json_tables/1").to route_to("json_tables#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/json_tables").to route_to("json_tables#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/json_tables/1").to route_to("json_tables#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/json_tables/1").to route_to("json_tables#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/json_tables/1").to route_to("json_tables#destroy", id: "1")
    end
  end
end
