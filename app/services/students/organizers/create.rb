module Students
    module Organizers
        class Create
        include Interactor::Organizer

        organize Users::Interactors::Create,
                 Students::Interactors::Create
        end
    end
end