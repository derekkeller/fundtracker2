class FinancialsController < ApplicationController
  before_filter :load_paths, :except => [:index_funds, :move_through_time, :change_view_type, :change_view_period]
  require 'financial_summary'
  require 'forecast_summary'
  require 'sales_percentage_summary'

  def index_funds
    @view_period = get_view_period()
    @view_type = get_view_type()

    @fund = Fund.find(params[:fund_id])

    case @view_period
    when 'year'
      @periods = get_year(session[:crement_period])
      @header_row_partial = "year_header"
    when 'quarter'
      @periods = get_quarter(session[:crement_period])
      @header_row_partial = "quarter_header"
    when 'month'
      @periods = get_month(session[:crement_period])
      @header_row_partial = "month_header"
    end

    case @view_type
    when 'forecast'
      @financial_summary = []
      @fund.companies.each do |company|
        @financial_summary << ForecastSummary.new(@periods, company)        
      end
    when 'sales'
      @financial_summary = []
      @fund.companies.each do |company|
        @financial_summary << SalesPercentageSummary.new(@periods, company)
      end
    else #actuals
      @financial_summary = []
      @fund.companies.each do |company|
        @financial_summary << FinancialSummary.new(@periods, company)        
      end 
    end
  end
  
  def index
    @view_period = get_view_period()
    @view_type = get_view_type()
  
    @company = Company.find(params[:company_id])

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
  
    case @view_type
    when 'forecast'
      @financial_summary = ForecastSummary.new(@periods, @company)
      @nh = 'nh'
    when 'sales'
      @financial_summary = SalesPercentageSummary.new(@periods, @company)
      @nh = 'nhp2'
    else #actuals
      @financial_summary = FinancialSummary.new(@periods, @company)
      @nh = 'nh'
    end
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

  def edit
    @financial = @company.financials.find(params[:id])    
  end

  def update
    @financial = @company.financials.find(params[:id])
    if @financial.update_attributes(params[:financial])
      redirect_to organization_fund_company_financials_path(@organization, @fund, @company), :flash => {:success => "Financial updated"}
    else
      render :edit
    end    
  end

  def show
  end

  def change_view_period
    set_view_period(params[:financial_id])
    if params[:company_id]
      redirect_to :action => :index, :organization_id => params[:organization_id], :fund_id => params[:fund_id], :company_id => params[:company_id]
    else
      redirect_to :action => :index_funds, :organization_id => params[:organization_id], :fund_id => params[:fund_id]
    end        
  end

  def change_view_type
    set_view_type(params[:financial_id])
    if params[:company_id]
      redirect_to :action => :index, :organization_id => params[:organization_id], :fund_id => params[:fund_id], :company_id => params[:company_id]
    else
      redirect_to :action => :index_funds, :organization_id => params[:organization_id], :fund_id => params[:fund_id]
    end
  end

  def move_through_time
    crement_period(params[:financial_id], params[:major])
    if params[:company_id]
      redirect_to :action => :index, :organization_id => params[:organization_id], :fund_id => params[:fund_id], :company_id => params[:company_id]
    else
      redirect_to :action => :index_funds, :organization_id => params[:organization_id], :fund_id => params[:fund_id]
    end
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
      @company = @fund.companies.find(params[:company_id])
    end

end
