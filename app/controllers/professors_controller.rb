class ProfessorsController < ApplicationController
    before_action :authenticate_devise_api_token!

    def create
        result = Professors::Interactors::Create.call(professor_params: professor_params)

        if result.success?
            render json: result.professor
        else
            render json: result.message
        end
    end

    private
    
    def professor_params
        params.require(:professor).permit(:user_id, :academic_degree, :description, :name)
    end
end
