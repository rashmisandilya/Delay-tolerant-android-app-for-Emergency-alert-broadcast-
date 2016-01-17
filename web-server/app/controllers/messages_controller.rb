class MessagesController < ApplicationController
  def index
  end

  def get_messages
    user = User.find(params[:user_id])
    respond_to do |format|
      format.html { render json: user.messages }
    end
  end

  def create
    msgAttr = {}
    msgAttr[:heading] = params[:heading]
    msgAttr[:content] = params[:content]
    msgAttr[:user_id] = params[:user_id]
    msg = Message.new(msgAttr)
    respond_to do |format|
      if msg.save
        format.html { render json: msg}
      else
        format.html { render text: 'Fail'}
      end
    end
  end
end
