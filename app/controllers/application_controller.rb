class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :header_categories
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :info, :warning

  def header_categories
    @header = HeaderPresenter.new(self)
  end
end
