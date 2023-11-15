module Students
    module Interactors
        class Create
        include Interactor

        delegate :student_params, :user, to: :context

        def call
            student = Student.new(student_params)
            student.user.id = user[:id]
            if student.save!
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