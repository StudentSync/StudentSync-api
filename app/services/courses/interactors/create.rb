module Courses
    module Interactors
        class Create

        include Interactor

        def call
            if course = Course.create!(context.course_params)
                context.course = course
            else
                context.failure!("create_course.failure")
            end
        end

        def rollback
            context.course.destroy
        end
        end
    end
end