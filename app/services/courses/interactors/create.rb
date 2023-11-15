module Courses
    module Interactors
        class Create
        include Interactor

        delegate :course_params, to: :context

        def call
            if course = Course.create!(course_params)
                context.course = course
            else
                context.fail!(message: "create_course.failure")
            end
        end

        def rollback
            context.course.destroy
        end
        end
    end
end