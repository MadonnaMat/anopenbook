class TokenController < ApplicationController
  def index
    render json: {
      token: form_authenticity_token,
      param: request_forgery_protection_token
    }
  end
end
