class MainPageController < ApplicationController
  def index
  end

  def login
    reply = ''
    user = User.find_by username: params[:username]
    if user
      if user.password == params[:password]
        reply = "Correct"
        if !user.token
          user.token = generateToken(user.username+user.password)
        end 
        user.reg_id = params[:regid]
        user.save
      else
        reply = "Incorrect Password"
      end

    else
      reply = "User not found"
    end

    respond_to do |format|
      if reply == 'Correct'
        format.html {render json: user}
      else
        format.html {render text: reply}
      end
    end
  end

  def login_front
    reply = ''
    user = User.find_by username: params[:username]
    if user
      logger.warn user.inspect
      if user.role != 1
        reply = "The User is not an Admin"
      elsif user.password == params[:password]
        reply = "Correct"
        if !user.token
          user.token = generateToken(user.username+user.password)
          user.save
        end
      else
        reply = "Incorrect Password"
      end

    else
      reply = "User not found"
    end

    respond_to do |format|
      if reply == 'Correct'
        format.html {render json: user}
      else
        format.html {render text: reply}
      end
    end
  end

  def signup
    reply = ''
    userParams = {}
    userParams[:username]   = params[:username]
    userParams[:password]   = params[:password]
    userParams[:degreeType] = params[:degreeType]
    userParams[:department] = params[:department]
    userParams[:firstname] = params[:firstname]
    userParams[:lastname] = params[:lastname]
    userParams[:international] = params[:international]
    userParams[:reg_id] = params[:regid]
    userParams[:token]      = generateToken(params[:username]+params[:password])
    userParams[:role] = 2
    user = User.new userParams

    logger.warn userParams
    if user.save
      reply = "Correct"
    else
      reply = "Fail"
    end
    logger.warn "reply: "+ reply

    if reply == "Correct"
      # Join department group
      if params[:department].upcase == "CSC" || params[:department].upcase == "ECE"
        user.join_group(Group.find_by(group_name: params[:department].upcase))
        logger.warn "1"
      end

      # Join degree group
      if params[:degreeType].downcase.capitalize == 'Graduate' || params[:degreeType].downcase.capitalize == 'Undergraduate'
        user.join_group(Group.find_by(group_name: params[:degreeType].downcase.capitalize))
        logger.warn "2"
      end

      # Join international group
      if params[:international] == 'true'
        user.join_group(Group.find_by(group_name: "International"))
        logger.warn "3"
      end
    end

    respond_to do |format|
      if reply == 'Correct'
        format.html {render json: user}
      else
        format.html {render text: reply}
      end
    end
  end
end
