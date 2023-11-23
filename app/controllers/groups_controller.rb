class GroupsController < ApplicationController
  before_action :authenticate_devise_api_token!

  def create
    result = Groups::Interactors::Create.call(group_params: group_params)

    if result.success?
      render json: result.group
    else
      render json: result.message
    end
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
end
