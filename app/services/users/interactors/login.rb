module Users
  module Interactors
      class Login
      include Interactor

      delegate :user_params, to: :context
      def call
          user = Devise::Api::ResourceOwnerService::SignIn.new(params: user_params.to_h,
                                                              resource_class: User).call
          if user.success?
            student = Student.find_by(user_id: user.success.resource_owner_id)
            role = ''
            name = ''
            if student
              role = 'student'
              name = student.name
            else
              professor = Professor.find_by(user_id: user.success.resource_owner_id)
              name = professor.name
              role = 'professor'
            end



              context.user = {
                  id: user.success.resource_owner_id,
                  token: user.success.access_token,
                  role: role,
                  name: name
              }
          else
              context.fail!(message: "Email or password incorrects!")
          end
      end
      end
  end
end