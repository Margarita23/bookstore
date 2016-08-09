class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
    if resource.persisted?
      GenerateUsersInstrumentsService.new(resource).call
    end
  end
end 