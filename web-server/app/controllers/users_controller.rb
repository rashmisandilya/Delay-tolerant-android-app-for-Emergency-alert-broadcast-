class UsersController < ApplicationController
  before_action :set_user, only: [:show, :join_group, :leave_group, :join_group_batch, :leave_group_batch, :get_groups, :get_join_groups, :update_gps, :update_regid]

  def show
    respond_to do |format|
      format.html { render json: @user }
    end
  end

  def create
    user = User.new(user_params)

    respond_to do |format|
      if user.save
        format.html { render text: "Success" }
      else
        format.html { render text: "Fail" }
      end
    end
  end

  def join_group_batch
    logger.warn params
    groups = eval(params[:group_ids])
    reply = "Success"
    for group in groups
      if not @user.join_group(Group.find_by(id: group))
        reply = "Fail"
      end
    end
    logger.warn reply

    respond_to do |format|
        format.html { render text: reply }
    end
  end

  def leave_group_batch
    logger.warn params
    reply = "Success"
    groups = eval(params[:group_ids])
    for group in groups
      if not @user.leave_group(Group.find_by(id: group))
        reply = "Fail"
      end
    end
    logger.warn reply

    respond_to do |format|
        format.html { render text: reply }
    end
  end

  def join_group
    respond_to do |format|
      if @user.join_group(Group.find_by(id: params[:group_id]))
        format.html { render text: "Success" }
      else
        format.html { render text: "Fail" }
      end
    end
  end

  def leave_group
    logger.warn params
    respond_to do |format|
      if @user.leave_group(Group.find_by(id: params[:group_id]))
        format.html { render text: "Success" }
      else
        format.html { render text: "Fail" }
      end
    end
  end

  def get_groups
    respond_to do |format|
      format.html { render json: @user.groups }
    end
  end

  def get_join_groups
    groups = Group.all 
    list = []
    for group in groups
      if not @user.groups.include? group
        list << group
      end
    end

    respond_to do |format|
      format.html { render json: list}
    end
  end

  def index
    users = User.all

    respond_to do |format|
      format.html { render json: users }
    end
  end

  def update_gps
    @user.longitude = params[:longitude]
    @user.latitude = params[:latitude]
    logger.warn params
    respond_to do |format|
      if @user.save
        format.html { render text: 'Success' }
      else
        format.html { render text: 'Fail' }
      end
    end
  end

  def update_regid
    @user.reg_id = params[:regid]
    respond_to do |format|
      if @user.save
        format.html { render text: 'Success' }
      else
        format.html { render text: 'Fail' }
      end
    end
  end

  def update
  end

  def destroy
  end

  def sendGCM
    logger.warn params
    data = {}
    data[:heading] = params[:data][:heading]
    data[:content] = params[:data][:content]
    reg_ids = params[:data][:reg_ids]
    res = sendGcmMsg(reg_ids, data)

    respond_to do |format|
      format.html { render json: res }
    end
  end

  def sendGCMtoGroup
    logger.warn params
    data = {}
    data[:heading] = params[:heading]
    data[:content] = params[:content]
    data[:group_id] = params[:group_id]

    reg_ids = []
    if params[:group_id].to_i != 0
      group = Group.find_by(id: params[:group_id])
      members = group.members
      for user in members
        if user.reg_id
          if not reg_ids.include? user.reg_id
            reg_ids.append(user.reg_id)
          end
        end
      end
    else
      current_user = User.find(params[:id])
      for u in User.all
        if u != current_user && current_user
          if u.reg_id
            if u.longitude && u.latitude && current_user.longitude && current_user.latitude
              if current_user.longitude > 0 && current_user.latitude > 0
                longitudeDif = (u.longitude - current_user.longitude).abs
                latitudeDif = (u.latitude - current_user.latitude).abs
                if longitudeDif < 0.2 and latitudeDif < 0.2
                  if not reg_ids.include? u.reg_id
                    reg_ids.append(u.reg_id)
                  end
                end
              end
            end
          end
        end
      end
    end

    logger.warn data
    logger.warn reg_ids
    res = sendGcmMsg(reg_ids, data)

    respond_to do |format|
      format.html { render json: res }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
