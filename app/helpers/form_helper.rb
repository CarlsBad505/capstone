module FormHelper
  def setup_user(user)
    user.customer ||= Customer.new
    user
  end
end