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

      uid { raw_info['organization']['id'] }

      info do
        {
          name: raw_info['user']['name'],
          user_id: raw_info['user']['id'],
          organization_id: raw_info['organization']['id'],
          team_id: raw_info['team']['id'],
          user_email: user_details['email'],
          user_role: user_details['role']
        }
      end

      extra do
        {
          raw_info: raw_info,
          user_details: user_details,
          token_info: access_token
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.miro.com/v1/oauth-token').parsed
      end

      def user_details
        org_id = raw_info['organization']['id']
        user_id = raw_info['user']['id']

        @user_details ||= access_token.get("https://api.miro.com/v2/orgs/#{org_id}/members/#{user_id}")
      end

      def callback_url
        full_host + callback_path
      end

      def token_params
        super.tap do |params|
          params[:client_id] = client.id
          params[:client_secret] = client.secret
          params[:redirect_uri] = callback_url
        end
      end
    end
  end
end
