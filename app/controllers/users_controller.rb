class UsersController < ApplicationController
  def login
    result = Users::Interactors::Login.call(user_params: user_params)

    if result.success?
      render json: result.user
    else
      render json: result.message
    end
  end 
end
