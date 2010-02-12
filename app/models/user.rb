require 'digest/sha1'

class User < CouchRestRails::Document
  use_database :user

  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  # validates_presence_of     :login
  # validates_length_of       :login,    :within => 3..40
  # validates_uniqueness_of   :login
  # validates_format_of       :login,    :with => Authentication.login_regex, :message => Authentication.bad_login_message
  # 
  # validates_format_of       :name,     :with => Authentication.name_regex,  :message => Authentication.bad_name_message, :allow_nil => true
  # validates_length_of       :name,     :maximum => 100
  # 
  # validates_presence_of     :email
  # validates_length_of       :email,    :within => 6..100 #r@a.wk
  # validates_uniqueness_of   :email
  # validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  # attr_accessible :login, :email, :name, :password, :password_confirmation

  # include CouchRest::Validation

  property :login
  property :email
  property :name
  property :password
  property :password_confirmation
  property :created_at
  property :updated_at
  property :salt
  property :crypted_password
  property :remember_token
  property :remember_token_expires_at

  # view_by :id
  # view_by :remember_token
  
  def self.find_by_remember_token(remember_token)
    User.first
  end
  
  def self.find_by_id(id)
    User.first
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    # return nil if login.blank? || password.blank?
    # u = find_by_login(login.downcase) # need to get the salt
    # u && u.authenticated?(password) ? u : nil
    # User.new :login => login, :password => password
    User.first
  end

  def login=(value)
    # write_attribute :login, (value ? value.downcase : nil)
    @login = (value ? value.downcase : nil)
  end

  def email=(value)
    # write_attribute :email, (value ? value.downcase : nil)
    @email = (value ? value.downcase : nil)
  end

  protected
    


end
