# frozen_string_literal: true

describe OmniAuth::Strategies::Miro do
  let(:miro_strategy) { described_class.new(nil) }
  let(:request) { instance_double('Request', params: {}, scheme: 'https', url: '/auth/miro/callback', env: { 'rack.input' => StringIO.new }) }

  let(:raw_info) do
    {
      'type' => 'oAuthToken',
      'createdBy' => {
        'type' => 'user',
        'name' => 'John Doe',
        'id' => '12345'
      },
      'organization' => {
        'type' => 'organization',
        'name' => 'Miro Test Org',
        'id' => '23456'
      },
      'user' => {
        'type' => 'user',
        'name' => 'John Doe',
        'id' => '12345'
      },
      'scopes' => [],
      'team' => {
        'type' => 'team',
        'name' => 'Miro Test Team',
        'id' => '34567'
      }
    }
  end

  before do
    allow(miro_strategy).to receive(:request).and_return(request)
  end

  describe '#client' do
    it 'has correct Miro api site' do
      expect(miro_strategy.options.client_options.site).to eq('https://miro.com/')
    end

    it 'has correct access token path' do
      expect(miro_strategy.options.client_options.token_url).to eq('https://api.miro.com/v1/oauth/token')
    end

    it 'has correct authorize url' do
      expect(miro_strategy.options.client_options.authorize_url).to eq('https://miro.com/oauth/authorize')
    end
  end

  describe '#info' do
    before do
      allow(miro_strategy).to receive(:raw_info).and_return(raw_info)
    end

    it 'returns the correct name' do
      expect(miro_strategy.info[:name]).to eq('John Doe')
    end

    it 'returns the correct organization id' do
      expect(miro_strategy.info[:organization_id]).to eq('23456')
    end

    it 'returns the correct user id' do
      expect(miro_strategy.info[:user_id]).to eq('12345')
    end

    it 'returns the correct team id' do
      expect(miro_strategy.info[:team_id]).to eq('34567')
    end
  end

  describe '#extra' do
    before do
      allow(miro_strategy).to receive(:raw_info).and_return(raw_info)
    end

    it 'includes the raw_info in extra data' do
      expect(miro_strategy.extra[:raw_info]).to eq(raw_info)
    end
  end

  describe '#callback_path' do
    it 'has the correct callback path' do
      expect(miro_strategy.callback_path).to eq('/auth/miro/callback')
    end
  end

  describe '#callback_url' do
    it 'has the correct callback path' do
      expect(miro_strategy.callback_url).to eq('/auth/miro/callback')
    end
  end

  describe '#raw_info' do
    let(:access_token) do
      instance_double('AccessToken', get: instance_double('Response', parsed: raw_info))
    end

    before do
      allow(miro_strategy).to receive(:access_token).and_return(access_token)
    end

    it 'fetches and parses the user profile information' do
      expect(miro_strategy.raw_info['team']['id']).to eq('34567')
      expect(miro_strategy.raw_info['organization']['id']).to eq('23456')
      expect(miro_strategy.raw_info['user']['id']).to eq('12345')
      expect(miro_strategy.raw_info['user']['name']).to eq('John Doe')
    end
  end
end
