require 'rails_helper'

RSpec.describe Api::V1::CampersController, type: :controller do
  # let!(:campsite) {Campsite.create!(name: "test site")}
  # let!(:camper_1) {Camper.create!(:name "Amy", campsite: campsite)}
  # let!(:camper_2) {Camper.create!(:name "Lynn", campsite: campsite)}
  let!(:amy_camper) { FactoryBot.create(:camper, name: "Amy") }
  before(:each) { FactoryBot.create_list(:camper, 5) }

  describe "GET#index" do

    it 'should return a list of all the campers' do
      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      expect(returned_json.length).to eq 1
      expect(returned_json["campers"].length).to eq 6

      expect(returned_json["campers"][0]["name"]).to eq amy_camper.name
    end
  end

  describe "POST#create" do
    let!(:new_camper) { FactoryBot.create(:camper, name: "Geoff") }
    let!(:camper_data) { { name: new_camper.name, campsite_id: new_camper.campsite_id}.to_json }

    it "should create a new camper" do
      expect{ post(:create, body: camper_data)}.to change{ Camper.count }.by 1
    end

    it 'should return a json with the new camper data' do
      post(:create, body: camper_data)
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq "application/json"

      expect(returned_json.length).to eq 1
      expect(returned_json["camper"]["name"]).to eq new_camper.name
      expect(returned_json["camper"]["campsite_id"]).to eq new_camper.campsite_id

    end
  end
end
