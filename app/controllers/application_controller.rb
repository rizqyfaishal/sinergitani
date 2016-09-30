class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception



  def get_provinces_data
    data = Province.all
    render :json => data
  end

  def get_regencies_data
    province = Province.find params[:id].to_i
    data = province.regencies
    render :json => data
  end

  def get_districts_data
    regency = Regency.find params[:id].to_i
    data = regency.districts
    render :json => data
  end

  def get_villages_data
    district = District.find params[:id].to_i
    data = district.villages
    render :json => data
  end

  private
  def check_kelompok_tani
    begin
      token = request.headers['Authorization'].split(' ').last
      payload, header = JsonWebToken.valid?(token)
      @current_kelompok_tani = KelompokTani.find(payload['user_id'].to_i)
    rescue
      render :json => {
          :error => 'Invalid Authorization Header'
      }, status: :unauthorized
    end
  end

  def check_donatur
    begin
      token = request.headers['Authorization'].split(' ').last
      payload = JsonWebToken.valid?(token)
      @current_donatur = Donatur.find(payload['user_id'].to_i)
    rescue
      render :json => {
          :errors => {
              :msg => 'Invalid Token'
          }
      }, status: :unauthorized
    end

  end


end
