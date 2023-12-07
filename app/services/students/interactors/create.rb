module Students
    module Interactors
        class Create
        include Interactor

        delegate :student_params, :user, to: :context

        def call
            student = Student.new(student_params)
            student.user_id = user[:id]
            if student.save!
                context.user_attributes = {
                    user_id: student.user_id,
                    email: User.find(student.user_id).email,
                    name: student.name,
                    role: "student",
                    course: Course.find(student.course_id).name,
                    schedule_availability: student.schedule_availability,
                    semester: student.semester,
                  }
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