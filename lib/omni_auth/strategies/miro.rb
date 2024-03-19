# frozen_string_literal: true

require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Miro < OmniAuth::Strategies::OAuth2
      option :name, :miro

      option :client_options, {
        site: 'https://miro.com/',
        authorize_url: 'https://miro.com/oauth/authorize',
        token_url: 'https://api.miro.com/v1/oauth/token'
      }

      uid { raw_info['team']['id'] }

      info do
        {
          name: raw_info['user']['name'],
          user_id: raw_info['user']['id'],
          organization_id: raw_info['organization']['id'],
          team_id: raw_info['team']['id']
        }
      end

      extra do
        {
          raw_info: raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/v1/oauth-token').parsed
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end
