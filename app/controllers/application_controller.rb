class ApplicationController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?
    puts "TOKEN: #{token.inspect}"    

    decoded = JsonWebToken.decode(token)
    puts "TOKEN: #{decoded.inspect}" 

    if decoded && decoded[:user_id]
      @current_user = User.find_by(id: decoded[:user_id])
   puts "USER FOUND: #{@current_user.inspect}" 

   end

    render json: { error: 'Unauthorized request' }, status: :unauthorized unless @current_user
  end
end

