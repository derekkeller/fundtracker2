class InvestmentsController < ApplicationController
  before_filter :load_paths

  def index
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
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
      @company = @fund.companies.find(params[:company_id])
    end

end
