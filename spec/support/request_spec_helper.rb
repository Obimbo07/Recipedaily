module RequestSpecHelper
  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: user.password } }
    response.headers['Set-Cookie']
  end
end
