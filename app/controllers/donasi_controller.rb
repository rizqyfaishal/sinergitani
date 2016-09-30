class DonasiController < ApplicationController

  layout false

  before_action :check_donatur

  def index
    donasis = @current_donatur.donasis
    render :json => {
        :data => donasis
    }, status: :ok
  end

  private
  def donasi_params
    params.permit(:amount)
  end
end
