class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      redirect_to organizations_path, :notice => "Organization created!"
    else
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
    @funds = @organization.funds
    @fund = @organization
  end

end
