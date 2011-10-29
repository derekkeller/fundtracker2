class OrganizationsController < ApplicationController
  def index
    session[:crement_period] = Date.today
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

  def edit
    @organization = Organization.find(params[:id])    
  end
  
  def update
    @organization = Organization.find(params[:id])
    if @organization.update_attributes(params[:organization])
      redirect_to :root, :flash => {:success => "Organization updated"}
    else
      render :edit
    end    
  end

end
