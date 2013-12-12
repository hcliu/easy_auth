require 'spec_helper'

describe EasyAuth do

  describe '#authenticate!' do

    context 'with correct token' do
      it 'does not reject the request' do
        ENV['API_TOKEN'] = 'good_token'
        controller = FakeController.new(:request => FakeRequest.new('good_token'))
        expect(controller).to_not receive(:reject_request)
        controller.easy_authenticate!
      end
    end

    context 'with wrong token' do
      it 'returns unauthorized' do
        ENV['API_TOKEN'] = 'THIS_WILL_NOT_MATCH_TOKEN'
        controller = FakeController.new(:request => FakeRequest.new('bad_token'))
        expect(controller).to receive(:render).with({:text => "bad api token", :status => :unauthorized})
        controller.easy_authenticate!
      end
    end
  end

end