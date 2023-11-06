module Students
    module Interactors
        class Create

        include Interactor

        def call
            if student = Student.create!(context.student_params)
                context.student = student
            else
                context.failure!("create_student.failure")
            end
        end

        def rollback
            context.student.destroy
        end

        end
    end
end