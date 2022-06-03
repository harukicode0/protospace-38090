class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:index, :show]

  private
    def configure_permitted_parameters  # メソッド名は慣習
      # deviseのUserモデルにパラメーターを許可
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :profile, :occupation, :position])
    end
end
