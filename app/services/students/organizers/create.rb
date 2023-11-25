module Students
    module Organizers
        class Create
        include Interactor::Organizer

        organize Users::Interactors::Register,
                 Students::Interactors::Create
        end
    end
end