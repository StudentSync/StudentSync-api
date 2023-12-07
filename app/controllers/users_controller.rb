class UsersController < ApplicationController
  def login
    result = Users::Interactors::Login.call(user_params: user_params)

    if result.success?
      render json: result.user
    else
      render json: result.message
    end
  end

  def verify_email
    user = User.find_by(email: params[:email])

    if user
      render json: {message: "Encontrado!"}, status: :ok
    else
      render json: {message: "Não encontrado!"}, status: :ok
    end
  end

end
