class Admin::Authenticator
  def initialize(admin_member)
    @administrator = admin_member
  end

  def authenticate(raw_password)
    @administrator &&
      @administrator.hashed_password &&
      BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end
end
