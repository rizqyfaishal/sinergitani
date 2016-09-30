class FundingController < ApplicationController

  layout false

  before_action :check_kelompok_tani

  def index
    fundings = Funding.all
    render :json => {
        :data => fundings
    }, status: :ok
  end

  def new
    render 'templates/funding/new'
  end

  def create
    kelompok_tani = KelompokTani.find(params[:kelompok_tani_id].to_i)
    if kelompok_tani
      funding = Funding.new funding_params
      kelompok_tani.funding.save(funding)
      render :json => {
          :data => funding
      }
    else
      render :json => {
          :errors => 'Not found'
      }, status: :not_found
    end
  end

  def show
    funding = Funding.find(params[:id])
    if funding
      render :json => {
          :data => funding
      }, status: :ok
    else
      render :json => {
          :errors => 'Not found'
      }, status: :not_found
    end
  end

  def edit
    render 'templates/funding/edit'
  end

  def update
    funding = Funding.find(params[:id])
    if funding
      begin
        funding.update funding_params
        render :json => {
            :data => funding
        }, status: :ok
      rescue
        render :json => {
            :errors => 'Error'
        }, status: :internal_server_error
      end
    else
      render :json => {

      }
    end
  end

  def destroy
    funding = Funding.find(params[:id])
    if funding
      if funding.delete
        render :json => {
            :data => funding
        }, status: :ok
      else
        render :json => {
            :errors => 'Error'
        },status: :internal_server_error
      end
    else
      render :json => {
          :errors => 'Not Found'
      }, status: :not_found
    end
  end

  private
  def funding_params
    params.permit(:title,:total,:deadline, :description)
  end
end
