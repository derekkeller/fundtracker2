class ReportsController < ApplicationController
  before_filter :load_paths

  def new
    @report = Report.new
  end

  def create
    @report = @company.reports.new(params[:report])
    if @report.save
      redirect_to organization_fund_company_report_path(@organization, @fund, @company, @report), :flash => {:success => "Report created"}
    else
      render :new
    end      
  end

  def index
    @reports = @company.reports.all
  end

  def show    
    @report_items = ["summary", "product", "management", "marketing", "business_development", "competition", "sales", "finance", "legal", "other"]
    @report = @company.reports.find(params[:id])
  end

  def show_filtered
    @report_items = ["summary", "product", "management", "marketing", "business_development", "competition", "sales", "finance", "legal", "other"]
    if params[:date][:report_year].present? &&
       params[:date][:report_month].present?
       
      @filtered_report = Report.last
    else
      report_date = Date.today.beginning_of_month
      @filtered_report = Report.last
    end

    render :update do |page|
      page.replace_html :report_holder, :partial => "report_content"
    end    
  end

  def edit
    @report = @company.reports.find(params[:id])
  end
  
  def update
    @report = @company.reports.find(params[:id])
    if @report.update_attributes(params[:report])
      redirect_to organization_fund_company_report_path(@organization, @fund, @company, @report), :flash => {:success => "Report updated"}
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
