class FinancialsController < ApplicationController
  before_filter :load_paths
  require 'financial_summary'


  def index
    @view_period = get_view_period()
    @company = Company.find(params[:company_id])

    session[:crement_period] = Date.today

    case @view_period
    when 'year'
      @periods = get_years(session[:crement_period])
      @header_row_partial = "yearly_header"
    when 'quarter'
      @periods = get_quarters(session[:crement_period])
      @header_row_partial = "quarterly_header"
    when 'month'
      @periods = get_months(session[:crement_period])
      @header_row_partial = "monthly_header"
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

  def change_view_period
    set_view_period(params[:financial_id])
    redirect_to :action => :index, :company_id => params[:company_id]
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
      @company = @fund.companies.find(params[:company_id])
    end

end
