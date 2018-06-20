class DogsController < ApplicationController
  before_action :set_organization
  before_action :set_organization_dog, only: [:show, :update, :destroy]

  # GET /organizations/:organization_id/dogs
  def index
    json_response(@organization.dogs)
  end

  # GET /organizations/:organization_id/dogs/:id
  def show
    json_response(@dog)
  end

  # POST /organizations/:organization_id/dogs
  def create
    @organization.dogs.create!(dog_params)
    json_response(@organization, :created)
  end

  # PUT /organizations/:organization_id/dogs/:id
  def update
    @dog.update(dog_params)
    head :no_content
  end

  # DELETE /organizations/:organization_id/dogs/:id
  def destroy
    @dog.destroy
    head :no_content
  end

  private

  def dog_params
    params.permit(:name, :done)
  end

  def set_organization
    @organization = Organization.find(params[:organization_id])
  end

  def set_organization_dog
    @dog = @organization.dogs.find_by!(id: params[:id]) if @organization
  end
end
