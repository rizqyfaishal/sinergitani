class DonaturController < ApplicationController

  before_action :check_donatur, :except => [:post_login, :register]

  def post_login
    donatur = Donatur.find_by_email(params[:email])
    if donatur && donatur.authenticate(params[:password])
      token = JsonWebToken.encode({:user_id => donatur.id})
      render :json => {
          :token => token,
          :user => donatur
      }
    else
      render :json => {
          :errors => {
              :msg => 'Invalid Credentials'
          }
      }, status: :unauthorized
    end
  end

  def register
    donatur = Donatur.new register_params
    if donatur.save
      token = JsonWebToken.encode({ :user_id => donatur.id})
      render :json => {
          :user => donatur,
          :token => token
      }
    else
      render :json => {
          :errors => {
              :msg => 'Something error'
          }
      },status: :unauthorized
    end
  end

  private
  def register_params
    params.permit(:name, :email, :phone, :password)
  end


end
