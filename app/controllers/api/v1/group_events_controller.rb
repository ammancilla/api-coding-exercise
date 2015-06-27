# Assumptions
# 
# - It is known than the id of the current user is 1
# 
class Api::V1::GroupEventsController < ApplicationController

  before_action :find_group_event, except: [:index, :create]

  def index
    render json: GroupEvent.all
  end

  def show
    render json: @group_event, root: false
  end

  def create
    # with authentication the first line of this method
    # would be the line bellow instead of the actual one
    # 
    # group_event = current_user.events.build(group_event_attrs)

    group_event = GroupEvent.new(group_event_attrs.merge(user_id: 1))
    
    if group_event.save
      render_created group_event
    else
      render_unprocessable group_event
    end
  end

  def update
    @group_event.assign_attributes(group_event_attrs.merge(user_id: 1))
    
    if @group_event.save
      render_created
    else
      render_unprocessable @group_event
    end
  end

  def destroy
    @group_event.mark_as_removed!
    head :no_content
  end

  private
    def find_group_event
      # with authentication finding the group even would be as shown bellow.
      # 
      # @group_event = current_user.events.find(params[:id])

      @group_event = GroupEvent.find(params[:id]) 
    end
    
    def group_event_attrs
      params.require(:group_event).permit(GroupEvent::BASE_ATTRIBUTES)
    end
end
