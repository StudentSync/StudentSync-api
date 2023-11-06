class StudentsController < ApplicationController
    before_action :authenticate_devise_api_token!

    def create
        result = Students::Interactors::Create.call(student_params: student_params)

        if result.success?
            render json: result.student
        else
            render json: result.message
        end
    end

    private

    def student_params
        params.require(:student).permit(:user_id, :course_id, :name, :semester, :schedule_availability)
    end
end
