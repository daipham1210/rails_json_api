class ApplicationController < ActionController::API
  include RenderJsonapi

  protected

  def paginate_params
    params.permit(:page, :per_page).to_h
  end
end
