class StudentsController < ApplicationController

    def create
        result = Students::Organizers::Create.call(student_params: student_params, user_params: user_params)

        if result.success?
            render json: { student: result.student, token: result.user[:token]}
        else
            render json: result.message
        end
    end

    private

    def student_params
        params.require(:student).permit(:user_id, :course_id, :name, :semester, :schedule_availability)
    end
end
