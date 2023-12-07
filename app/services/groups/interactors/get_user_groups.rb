module Groups
  module Interactors
    class GetUserGroups
    include Interactor

    delegate :user_id, to: :context

    def call
      
    owner_groups = Group.where(user_id: user_id)
    participant_groups = GroupUser.where(user_id: user_id, status: "active")

    end

    def rollback
      context.group.destroy
    end

    end
  end 
end