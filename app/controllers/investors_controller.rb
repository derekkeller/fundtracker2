class InvestorsController < ApplicationController
  before_filter :load_paths

  def new
    @investor = @organization.investors.new
  end

  def create
    @organization = Organization.find(params[:organization_id])
    @investor = @organization.investors.new(params[:investor])
    if @investor.save
      redirect_to organization_investors_path(@organization), :flash => {:success => "Investor added"}
    else
      render :new
    end    
  end

  def index
    @investors = @organization.investors
  end

  def show
    @investor = @organization.investors.find(params[:id])
    @users = User.all
    @tasks = @investor.tasks.all
    @events = @investor.events.all
  end

  def edit
  end


  private
    def load_paths
      @organization = Organization.find(params[:organization_id])      
    end

end
