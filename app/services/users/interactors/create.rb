module Users
    module Interactors
        class Create
        include Interactor

        delegate :user_params, to: :context
        def call
            user = Devise::Api::ResourceOwnerService::SignUp.new(params: user_params.to_h,
                                                                resource_class: User).call
            if user.success?
                context.user = {
                    id: user.success.resource_owner_id,
                    token: user.success.access_token
                }
            else
                if user_params[:password].length < 6
                    context.fail!(message: "Password is too short!")
                elsif User.find_by(email: user_params[:email])
                    context.fail!(message: "Email already exists!")
                end
            end
        end

        def rollback
            User.find(context.user[:id]).destroy
        end

        end
    end
end