class GroupsController < ApplicationController
  before_action :authenticate_devise_api_token!

  def create
    result = Groups::Interactors::Create.call(group_params: group_params)

    if result.success?
      render json: {group: result.group,members: result.group_users}
    else
      render json: result.message
    end
  end

  def get_user_groups
    result = Groups::Interactors::GetUserGroups.call(user_id: params[:user_id])

  end

  private
  def group_params
    params.require(:group).permit(:name, :user_id, group_users_attributes: [:user_id ])
  end

end
