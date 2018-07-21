Redmine::Plugin.register :redmine_social_sign_in do
  name 'Social Sign In'
  author ' tak'
  description 'sign in through oauth2.0'
  version '1.0.3'
  url ''

  settings partial: 'settings/redmine_social_sign_in',
           default: {
               'pptv_enabled'        => '0',
               'pptv_app_id'         => '',
               'pptv_app_secret'     => ''
           }
end

if Redmine::Plugin.registered_plugins[:easy_extensions].nil?
  require_relative 'after_init'
end
