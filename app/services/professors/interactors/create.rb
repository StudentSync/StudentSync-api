module Professors
    module Interactors
        class Create
        include Interactor
        
        def call
            if professor = Professor.create!(context.professor_params)
                context.professor = professor
            else
                context.failure!("create_professor.failure")
            end
        end

        def rollback
            context.professor.destroy
        end
        end
    end
end