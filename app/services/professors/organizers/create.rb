module Professors
    module Organizers
        class Create
        include Interactor::Organizer

        organize Users::Interactors::Create,
                 Professors::Interactors::Create
        end
    end
end