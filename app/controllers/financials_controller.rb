class FinancialsController < ApplicationController
  before_filter :load_paths

  def index
    @view_by = get_view_by()
    # @company = Company.find(params[:company_id])

    session[:period] = Date.today

    case @view_by
    when 'year'
      @periods = get_years(session[:period])
    when 'quarter'
      @periods = get_quarters(session[:period])
    when 'month'
      @periods = get_months(session[:period])
    end
    
    @financial_summary = FinancialSummary.new(@periods, @company)

  end

  def new
    @financial = @company.financials.new
  end

  def create
    @financial = @company.financials.new(params[:financial])
    if @financial.save
      redirect_to organization_fund_company_financials_path(@organization, @fund, @company, @financial), :flash => {:success => "Financial created"}
    else
      render :new
    end    
  end

  def show
  end

  def change_period
    set_period_type(params[:financial_id])
    redirect_to :show, :company_id => params[:company_id]
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
      @company = @fund.companies.find(params[:company_id])
    end

end
