class AuthTestController < ApplicationController

 def index
   
 puts "@current_user: #{@current_user.inspect}"
 render json: { message: "You're authorized!", user: @current_user }
  end

end
