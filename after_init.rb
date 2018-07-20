require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class SomeSite < OmniAuth::Strategies::OAuth2
      # Give your strategy a name.
      option :name, "pptv"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => "http://localhost",
        :authorize_url => 'http://localhost/oauth/authorize?response_type=code',
        :token_url => 'http://localhost/oauth/token'
      }

      option :scope, ''

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        {
          :name => raw_info['name'],
          :email => raw_info['email']
          :first_name => raw_info['name'],
          :last_name => raw_info['name']
        }
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

ActionDispatch::Reloader.to_prepare do

  require 'redmine_social_sign_in/hooks'

end

Rails.application.config.middleware.use OmniAuth::Builder do

  provider :google_oauth2, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['google_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['google_app_secret']
  }, scope:                       'email,profile', path_prefix: '/social_sign_in'

  provider :facebook, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['facebook_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['facebook_app_secret']
  }, scope:                  'email,public_profile', path_prefix: '/social_sign_in'

  provider :linkedin, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['linkedin_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['linkedin_app_secret']
  }, path_prefix:            '/social_sign_in'

  provider :twitter, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['twitter_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['twitter_app_secret']
  }, path_prefix:           '/social_sign_in'

  provider :qq_connect, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['qq_connect_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['qq_connect_app_secret']
  }, scope:                    'get_user_info', path_prefix: '/social_sign_in'

  provider :wechat, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['wechat_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['wechat_app_secret']
  }, scope:                'snsapi_userinfo', path_prefix: '/social_sign_in'

  provider :pptv, setup: -> (env) {
    env['omniauth.strategy'].options[:client_id]     = Setting.plugin_redmine_social_sign_in['pptv_app_id']
    env['omniauth.strategy'].options[:client_secret] = Setting.plugin_redmine_social_sign_in['pptv_app_secret']
  }, path_prefix: '/social_sign_in'

end

