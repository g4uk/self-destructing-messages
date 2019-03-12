require 'spec_helper'

describe App do
  def app
    App
  end

  context 'GET index' do
    before(:each) do
      get '/'
    end

    context 'returns 200' do
      it { expect(last_response.status).to eq 200 }
    end

    context 'response include add form html' do
      it { expect(last_response.body).to match /message-form/im }

      context 'form includes message destruction methods' do
        it { expect(last_response.body).to match /#{MessageDestruction::METHOD_NUMBER_OF_HOURS}/im }
        it { expect(last_response.body).to match /#{MessageDestruction::METHOD_NUMBER_OF_LINK}/im }
      end
    end
  end

  context 'POST create message' do
    let(:message_text) { 'test' }
    let(:params) do
      { message: message_text, destruction_method: MessageDestruction::METHOD_NUMBER_OF_LINK, destruction_value: 1 }
    end

    before(:each) do
      post '/message', params
    end

    context 'create successfully' do
      context 'is redirected?' do
        it { expect(last_response.redirect?).to be_truthy }
        it { follow_redirect!; expect(last_request.path).to eq('/') }
      end

      context 'add message working correct' do
        it { expect(Message.last.message).to eq(message_text) }
      end
    end

    context 'create with errors' do
      let(:params) { {} }

      context 'is redirected?' do
        it { expect(last_response.redirect?).to be_truthy }
        it { follow_redirect!; expect(last_request.path).to eq('/') }
      end

      context 'add message working correct' do
        it { expect(Message.last).to be_nil }
      end

      context 'include error' do
        it { follow_redirect!; expect(last_response.body).to match /Message can't be blank/im }
      end
    end
  end

  context 'GET message' do
    let(:message) { create(:message) }

    context 'rendered show message page' do
      it do
        create(:message_destruction, message_id: message.id)
        get "/message/#{message.id}"
        expect(last_response.body).to match /show-message/im
      end
    end

    context 'message changed as destructed' do
      it do
        create(:message_destruction, message_id: message.id)
        get "/message/#{message.id}"
        expect(message.reload.destructed).to be_truthy
      end
    end

    context 'message is not changed as destructed' do
      it do
        create(:message_destruction, message_id: message.id, value: 2)
        get "/message/#{message.id}"
        expect(message.reload.destructed).to be_falsey
      end
    end

    context 'number_of_link incremented' do
      it do
        create(:message_destruction, message_id: message.id)
        get "/message/#{message.id}"
        expect(message.reload.number_of_link).to eq(1)
      end
    end
  end
end