class ProfessorsController < ApplicationController

    def create
        result = Professors::Organizers::Create.call(professor_params: professor_params, user_params: user_params)

        if result.success?
            render json: { professor: result.professor, token: result.user[:token]}
        else
            render json: result.message
        end
    end

    private
    
    def professor_params
        params.require(:professor).permit(:user_id, :academic_degree, :description, :name)
    end
end
