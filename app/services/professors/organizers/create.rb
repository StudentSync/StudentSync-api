module Professors
    module Organizers
        class Create
        include Interactor::Organizer

        organize Users::Interactors::Register,
                 Professors::Interactors::Create
        end
    end
end