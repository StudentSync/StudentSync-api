module Professors
    module Interactors
        class Create
        include Interactor

        delegate :professor_params, :user, to: :context

        def call
            professor = Professor.new(professor_params)
            professor.user_id = user[:id]
            if professor.save!
                context.user_attributes = {
                    user_id: professor.user_id,
                    email: User.find(professor.user_id).email,
                    name: professor.name,
                    role: "teacher",
                    academic_degree: professor.academic_degree,
                    description: professor.description,
                    schedule_availability: professor.schedule_availability,
                  }
            else
                context.fail!(message: "create_professor.failure")
            end
        end

        def rollback
            context.professor.destroy
        end
        
        end
    end
end