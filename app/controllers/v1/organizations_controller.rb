module V1
  class OrganizationsController < ApplicationController
    before_action :set_organization, only: [:show, :update, :destroy]
    skip_before_action :authorize_request, only: [:index, :show]

    # GET /organizations
    def index
      @organizations = Organization.all.paginate(page: params[:page], per_page: 20)
      json_response(@organizations)
    end

    # POST /organizations
    def create
      @organization = current_user.organizations.create!(organization_params)
      json_response(@organization, :created)
    end

    # GET /organizations/:id
    def show
      json_response(@organization)
    end

    # PUT /organizations/:id
    def update
      @organization.update(organization_params)
      head :no_content
    end

    # DELETE /organizations/:id
    def destroy
      @organization.destroy
      head :no_content
    end

    private

    def organization_params
      # whitelist params
      params.permit(:name, :line1, :line2, :city, :state, :zipcode, :phone, :website)
    end

    def set_organization
      @organization = Organization.find(params[:id])
    end
  end
end
