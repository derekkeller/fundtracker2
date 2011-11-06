class TasksController < ApplicationController
  before_filter :load_paths

  def index
  end

  def new
    @task = @investor.tasks.new
  end
  
  def create
    @task = @investor.tasks.new(params[:task])
    if @task.save
      redirect_to organization_investor_path(@organization, @investor), :flash => {:success => 'Task Added'}
    else
      render :new
    end
  end
  
  def show
    @task = @investor.tasks.find(params[:id])    
  end
  
  def edit
    @task = @investor.tasks.find(params[:id])    
  end
  
  def update
    @task = @investor.tasks.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to organization_investor_path(@organization, @investor), :flash => {:success => 'Task Updated'}
    else
      render :edit
    end
  end

  def destroy
    @task = @investor.tasks.find(params[:id])
    @task.destroy
    redirect_to organization_investor_path(@organization, @investor), :flash => {:success => 'Task Deleted'}  
  end

  private
    def load_paths
      @organization = Organization.find(params[:organization_id])
      @investor = @organization.investors.find(params[:investor_id])
    end

end
