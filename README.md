# Redmine Laravel Passport Sign In
Plugin into Redmine that enables sign in through laravel passport

## Install
Copy plugin into [redmine_app]/plugins/redmine_laravel_passport_sign_in directory
Run "**bundle update**" from [redmine_app] command line and restart your web server

## Setup
Edit after_init.rb -> Overwrite client_option
Go to Administration -> Plugins -> Laravel Passport Sign In and click to "Configure" button.
Enable your laravel_passport network and fill OAuth credentials like "Client ID" and "Client secret"
