class StudentsController < ApplicationController

    def create
        result = Students::Organizers::Create.call(student_params: student_params, user_params: user_params)

        if result.success?
            render json: { user_attributes: result.user_attributes, token: result.user[:token]}
        else
            render json: result.message
        end
    end

    private

    def student_params
        params.require(:student).permit(:course_id, :name, :semester, :schedule_availability)
    end
end
