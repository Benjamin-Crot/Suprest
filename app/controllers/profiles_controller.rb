class ProfilesController < ApplicationController
  def show
    @user = current_user
    @profile = @user.profile
    authorize @profile
    @roles = @user.roles
    @accounts = []
    @roles.each do |role|
      @accounts << Account.find(role.account_id)
    end
  end
end
