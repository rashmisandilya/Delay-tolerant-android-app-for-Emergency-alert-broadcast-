class GroupsController < ApplicationController
  def index
    groups = Group.all

    respond_to do |format|
      format.html { render json: groups }
    end
  end

  def create
    group = Group.new(group_params)

    respond_to do |format|
      if group.save
        format.html { render text: 'Success' }
      else
        format.html { render text: 'Fail' }
      end

    end
  end

  def show
  end

  def update
  end

  def destroy
  end

  def get_members
    group = Group.find_by(id: params[:id])
    respond_to do |format|
      format.html { render json: group.members }
    end
  end

  private  
    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:group_name)
    end
end
