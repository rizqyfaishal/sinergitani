class KelompokTaniController < ApplicationController

  before_action :check_kelompok_tani , :except => [:register, :post_login]

  def index
    render :'kelompok_tani/index'
  end

  def register
    kelompok_tani = KelompokTani.new kelompok_tani_register_params
    if kelompok_tani.save
      token = JsonWebToken.encode({ :user_id => kelompok_tani.id})
      render :json => {
          :token => token,
          :user => kelompok_tani
      }
    else
      render :json => {
          :errors => @kelompok_tani.errors
      }
    end
  end

  def post_login
    kelompok_tani = KelompokTani.find_by_email(params[:email])
    if kelompok_tani && kelompok_tani.authenticate(params[:password])
      token = JsonWebToken.encode({ :user_id => kelompok_tani.id })
      render :json => {
          :token => token,
          :user => kelompok_tani
      }
    else
      render :json => {
          :error => {
              :msg => 'Invalid credential'
          }
      }, status: :unauthorized
    end
  end

  private
  def kelompok_tani_register_params
    params.permit(:name,:password,:province_id,:regency_id,:district_id,:village_id,:group_name,:email,:phone,:password)
  end



end
