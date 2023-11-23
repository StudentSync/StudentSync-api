class GroupsController < ApplicationController
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
