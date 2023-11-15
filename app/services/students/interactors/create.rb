module Students
    module Interactors
        class Create
        include Interactor

        delegate :student_params, to: :context

        def call
            if student = Student.create!(student_params)
                context.student = student
            else
                context.fail!(message: "create_student.failure")
            end
        end

        def rollback
            context.student.destroy
        end

        end
    end
end