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
    reset_session
    session[:crement_period] = Date.today
    @company = @fund.companies.find(params[:id])
  end

  def edit
    @company = @fund.companies.find(params[:id])    
  end

  def update
    @company = @fund.companies.find(params[:id])
    if @company.update_attributes(params[:company])
      redirect_to organization_fund_company_path(@organization, @fund, @company), :flash => {:success => "Company updated"}
    else
      render :edit
    end
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
    end

end
