module Professors
    module Interactors
        class Create
        include Interactor

        delegate :professor_params, :user, to: :context

        def call
            professor = Professor.new(professor_params)
            professor.user_id = user[:id]
            if professor.save!
                context.professor = professor
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