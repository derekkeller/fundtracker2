class FundsController < ApplicationController

  def index
  end

  def new
    @organization = Organization.find(params[:organization_id])
    @fund = @organization.funds.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @fund = @organization.funds.new(params[:fund])
    if @fund.save
      redirect_to @organization, :flash => {:success => "Fund created"}
    else
      render :new
    end      
  end

  def show
    @organization = Organization.find(params[:organization_id])
    @fund = @organization.funds.find(params[:id])
  end

  def edit
    @organization = Organization.find(params[:organization_id])
    @fund = @organization.funds.find(params[:id])  
  end

  def update
    @organization = Organization.find(params[:organization_id])
    @fund = @organization.funds.find(params[:id])
    if @fund.update_attributes(params[:fund])
      redirect_to @organization, :flash => {:success => "Fund updated"}
    else
      render :edit
    end
  end

end
