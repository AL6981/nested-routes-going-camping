class Api::V1::CampersController < ApplicationController
  def index
    render json: Camper.all
  end

  def create
    payloadData = JSON.parse(request.body.read)
    new_camper = Camper.create(name: payloadData["name"], campsite_id: payloadData["campsite_id"])
    render json: new_camper
  end
end
