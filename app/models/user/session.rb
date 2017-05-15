class User::Session < Authlogic::Session::Base

  authenticate_with User

  consecutive_failed_logins_limit 3
  failed_login_ban_for 15.minutes
  last_request_at_threshold 1.minute

  find_by_login_method :find_by_lowercase_email_or_login
end