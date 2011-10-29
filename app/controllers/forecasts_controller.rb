class ForecastsController < ApplicationController
  before_filter :load_paths

  def edit
    @forecast = @company.forecasts.find(params[:id])    
  end
  
  
  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @fund = @organization.funds.find(params[:fund_id])      
      @company = @fund.companies.find(params[:company_id])
    end

end
