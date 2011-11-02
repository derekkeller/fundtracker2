class InvestmentsController < ApplicationController
  before_filter :load_paths

  def index
    @investments = @company.investments.all
  end

  def new
    @investment = @company.investments.new
  end
  
  def create
    @investment = @company.investments.new(params[:investment])
    if @investment.save
      redirect_to organization_fund_company_path(@organization, @fund, @company) , :flash => {:success => "Investment added"}
    else
      render :new
    end    
  end

  def show
    @investment = @company.investments.find(params[:id])
    @investments = @company.investments.all
  end

  def edit
    @investment = @company.investments.find(params[:id])
  end
  
  def update
    @investment = @company.investments.find(params[:id])
    if @investment.update_attributes(params[:investment])
      redirect_to organization_fund_company_investment_path(@organization, @fund, @company, @investment), :flash => {:success => "Invesetment updated"}
    else
      render :edit
    end
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
      @company = @fund.companies.find(params[:company_id])
    end

end
