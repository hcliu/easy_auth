require 'rails/all'

class FakeController < ActionController::Base

  include EasyAuth

  attr_reader :request

  def initialize *args
    opts = args.extract_options!
    @request = opts.fetch(:request) { FakeRequest.new('random_token') }
  end

end

class FakeHeaders < Struct.new(:env);end

class FakeRequest

  attr_accessor :token, :headers

  def initialize token
    @token = token
    @headers = FakeHeaders.new({'HTTP_X_API_TOKEN' => token})
  end

  def env
    {'HTTP_X_API_TOKEN' => token}
  end

end