require 'rails/all'

class FakeController < ActionController::Base

  include EasyAuth

  attr_reader :request

  def initialize *args
    opts = args.extract_options!
    @request = opts.fetch(:request) { FakeRequest.new('random_token') }
  end

end

class FakeRequest

  attr_accessor :token

  def initialize token
    @token = token
  end

  def env
    {'HTTP_X_API_TOKEN' => token}
  end

end