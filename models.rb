class User < Sequel::Model

  attr_accessor :password

  def before_save
    encrypt_password
    super
  end

  def self.authenticate email, password
    u = User.find(email: email)
    if u.encrypted_password == BCrypt::Password.create(password)
      u
    else
      false
    end
  end

  private

  def encrypt_password
    self[:encrypted_password] = BCrypt::Password.create(self.password)
  end

end
