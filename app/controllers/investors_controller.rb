class InvestorsController < ApplicationController
  before_filter :load_paths, :except => :destroy

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
    @users = @investor.users.all
    @tasks = @investor.tasks.all
    @events = @investor.events.all
  end

  def edit
    @investor = @organization.investors.find(params[:id])
  end

  def update
    @investor = @organization.investors.find(params[:id])
    if @investor.update_attributes(params[:investor])
      redirect_to organization_investor_path(@organization, @investor), :flash => {:success => 'Investor Updated'}
    else
      render :edit
    end    
  end

  def destroy
    @investor = Investor.find(params[:id])
    @investor.destroy
    redirect_to organizations_path, :flash => {:success => 'Investor Removed'}
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])      
    end

end
