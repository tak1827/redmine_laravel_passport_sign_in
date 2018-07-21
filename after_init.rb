require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Pptv < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "pptv"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => "http://172.17.0.3",
        :authorize_url => 'http://127.0.0.1/oauth/authorize',
        :token_url => 'http://172.17.0.3/oauth/token'
      }

      #option :client_id, Setting.plugin_redmine_social_sign_in['pptv_app_id']
      #option :client_secret, Setting.plugin_redmine_social_sign_in['pptv_app_secret']
      option :scope, ''
      option :provider_ignores_state, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email'],
          :first_name => raw_info['name'],
          :last_name => raw_info['name']
        }
      end

      def callback_url
        full_host + script_name + callback_path
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/user').parsed
      end
    end
  end
end

OmniAuth.config.add_camelization 'pptv', 'Pptv'

ActionDispatch::Reloader.to_prepare do

  require 'redmine_social_sign_in/hooks'

end

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :pptv, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['pptv_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['pptv_app_secret']
  }, path_prefix: '/social_sign_in'

end


