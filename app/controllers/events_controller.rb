class EventsController < ApplicationController
  before_filter :load_paths

  def index
    @events = @organization.events.all  
  end

  def show
    @event = @investor.events.find(params[:id])
  end

  def new
    @event = @investor.events.new
    @breadcrumb = "Investors > #{@investor.name} > Add Event"
    @user_investors = User.where('investor_id = ?', @investor)
  end
  
  def create
    # if current_user.present?
    #   @event = @investor.events.new(params[:event].merge(:user_id => current_user.id))
    # else
      @event = @investor.events.new(params[:event])
    # end
    
    if @event.save
      redirect_to organization_investor_path(@organization, @investor), :flash => {:success => 'Event Created'}
    else
      render :new
    end
  end

  def edit
    @event = @investor.events.find(params[:id])
    @breadcrumb = "Investors > #{@investor.name} > #{@event.name} > Edit"
    @user_investors = User.where('investor_id = ?', @investor)
    
    @refer_id = params[:refer_id]
  end
  
  def update
    params[:event][:attendee_ids] ||= []
    @event = @investor.events.find(params[:id])
    
    if @event.update_attributes(params[:event])
      if params[:refer_id] == 'event_index'
        redirect_to events_path
      else
        redirect_to organization_investor_path(@organization, @investor)
      end
    else
      render :edit
    end
  end

  def destroy
    @event = @investor.events.find(params[:id])
    @event.destroy
      render :update do |page|
    end
  end

  private
  def load_paths
    @organization = Organization.find(params[:organization_id]) 
    @investor = @organization.investors.find(params[:investor_id])
  end   

end
