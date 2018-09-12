# Dummy controller for versioning test
class V2::OrganizationsController < ApplicationController
  def index
    json_response({message: 'Hello there'})
  end
end
