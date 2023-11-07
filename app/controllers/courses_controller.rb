class CoursesController < ApplicationController
    before_action :authenticate_devise_api_token!

    def create
        result = Courses::Interactors::Create.call(course_params: course_params)

        if result.success?
            render json: result.course
        else
            render json: result.message
        end
    end
    
    def all
        courses = Course.all
        render json: courses
    end

    private

    def course_params
        params.require(:course).permit(:name)
    end
end
