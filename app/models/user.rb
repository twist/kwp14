class User < ActiveRecord::Base
  attr_accessible :crypted_password, :email, :password_salt, :persistence_token, :username, :first_name, :last_name, :password_confirmation, :password
  acts_as_authentic do |c| c.login_field = :email end

  has_and_belongs_to_many :roles


  def has_role?(role_name)
    roles.each do |r|
      if r.name == role_name
        return true
      end
    end
    return false
  end

  def encrypt_email_and_save
    md5_email = Digest::MD5.hexdigest(email)
    update_attribute(:email, md5_email)
    save(:validate => false)
  end 
end
