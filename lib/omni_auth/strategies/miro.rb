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
          team_id: raw_info['team']['id']
        }
      end

      extra do
        {
          raw_info: raw_info,
          token_info: access_token
        }
      end

      def raw_info
        @raw_info ||= access_token.get('https://api.miro.com/v1/oauth-token').parsed
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

      def callback_phase
        error = request.params['error_reason'] || request.params['error']
        if !options.provider_ignores_state && (request.params['state'].to_s.empty? || request.params['state'] != session.delete('omniauth.state'))
          fail!(:csrf_detected, CallbackError.new(:csrf_detected, 'CSRF detected'))
        elsif error
          fail!(error,
                CallbackError.new(request.params['error'], request.params['error_description'] || request.params['error_reason'], request.params['error_uri']))
        else
          self.access_token = build_access_token
          env['omniauth.auth'] = auth_hash
          call_app!
        end
      rescue ::OAuth2::Error, CallbackError => e
        fail!(:invalid_credentials, e)
      rescue ::Timeout::Error, ::Errno::ETIMEDOUT => e
        fail!(:timeout, e)
      rescue ::SocketError => e
        fail!(:failed_to_connect, e)
      end
    end
  end
end
