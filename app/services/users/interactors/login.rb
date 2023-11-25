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
            if student
              user_attributes = {
                user_id: student.user_id,
                email: User.find(student.user_id).email,
                name: student.name,
                role: "student",
                course: Course.find(student.course_id).name,
                schedule_availability: student.schedule_availability,
                semester: student.semester,
              }
            else
              professor = Professor.find_by(user_id: user.success.resource_owner_id)
              user_attributes = {
                user_id: professor.user_id,
                email: User.find(professor.user_id).email,
                name: professor.name,
                academic_degree: professor.academic_degree,
                description: professor.description,
                schedule_availability: professor.schedule_availability,
              }
            end

              context.user = {
                  user_attributes: user_attributes,
                  token: user.success.access_token,
              }
          else
              context.fail!(message: "Email or password incorrects!")
          end
      end
      end
  end
end