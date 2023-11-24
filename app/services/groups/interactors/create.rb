module Groups
  module Interactors
    class Create
    include Interactor

    delegate :group_params, to: :context

    def call
      
      if group = Group.create!(group_params)
        context.group = group
        context.group_users = group.group_users
      else
        context.fail!(message: "create_group.failure")
      end
    
    end

    def rollback
      context.group.destroy
    end

    end
  end 
end