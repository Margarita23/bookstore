# RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    return root_path unless resource.persisted?
    GenerateUsersInstrumentsService.new(resource).call
  end
end
