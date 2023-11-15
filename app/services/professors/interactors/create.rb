module Professors
    module Interactors
        class Create
        include Interactor
        
        delegate :professor_params, to: :context
        def call
            if professor = Professor.create!(professor_params)
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