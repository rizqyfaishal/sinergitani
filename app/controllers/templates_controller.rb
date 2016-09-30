class TemplatesController < ApplicationController

  layout false

  def index
    render :'templates/index'
  end

  def login
    render :'templates/login'
  end

  def register
    render :'templates/register'
  end

  def funding_index
    render :'templates/funding/index'
  end

  def kelompok_tani_index
    render :'templates/kelompok_tani/index'
  end
end
