require "easy_auth/version"

module EasyAuth

  def authenticate_token
    reject_request unless authenticated?
  end
  alias_method :easy_authenticate!, :authenticate_token

  def reject_request
    render(:text => 'bad api token', :status => :unauthorized) and return
  end

  def authenticated?
    request_auth_token == authentication_token
  end

  def request_auth_token
    request.headers['HTTP_X_API_TOKEN'] || request.env['HTTP_X_API_TOKEN'] || params[:api_token]
  end

  def authentication_token
    ENV.fetch('API_TOKEN') { 'DEV_TOKEN' }
  end
end
