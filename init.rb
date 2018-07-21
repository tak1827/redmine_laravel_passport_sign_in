Redmine::Plugin.register :redmine_laravel_passport_sign_in do
  name 'Laravel Passport Sign In'
  author ' tak'
  description 'sign in through laravel passport'
  version '1.0.3'
  url ''

  settings partial: 'settings/redmine_laravel_passport_sign_in',
           default: {
               'passport_enabled'        => '0',
               'passport_app_id'         => '',
               'passport_app_secret'     => ''
           }
end

if Redmine::Plugin.registered_plugins[:easy_extensions].nil?
  require_relative 'after_init'
end
