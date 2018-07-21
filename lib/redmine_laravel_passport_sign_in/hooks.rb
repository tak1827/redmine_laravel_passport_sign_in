module RedmineLaravelPassportSignIn
  class Hooks < Redmine::Hook::ViewListener

    render_on :view_account_login_bottom, partial: 'redmine_laravel_passport_sign_in/view_account_login_bottom'

  end
end
