class User::BaseController < ApplicationController
  layout "user_dashboard"
  before_action :authenticate_user!
  before_action :ensure_regular_user!

  private

  def ensure_regular_user!
    redirect_to root_path unless current_user&.user?
  end
end
