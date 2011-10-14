class CompaniesController < ApplicationController
  before_filter :load_paths

  def index
  end

  def new
    @company = @fund.companies.new
  end
  
  def create
    @company = @fund.companies.new(params[:company])
    if @company.save
      redirect_to organization_fund_path(@organization, @fund), :flash => {:success => "Company created"}
    else
      render :new
    end
  end

  def show
    @company = @fund.companies.find(params[:id])
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
    end

end
