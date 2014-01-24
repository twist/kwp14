class User < ActiveRecord::Base
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username, :first_name, :last_name, :password_confirmation, :password
  acts_as_authentic do |c| c.login_field = :email end

  def encrypt_email_and_save
    md5_email = Digest::MD5.hexdigest(email)
    update_attribute(:email, md5_email)
    pp save(:validate => false)
  end 
end
