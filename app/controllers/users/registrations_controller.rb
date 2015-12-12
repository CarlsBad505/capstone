class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
# before_filter :customer_params
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    build_resource({})
    resource.build_customer
    respond_with resource
    @user = resource
  end

  # POST /resource
  def create
    build_resource(user_params)
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_unconfirmed#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, user_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def user_params
    devise_parameter_sanitizer.sanitize(:sign_up) { |u|
      u.permit(:email, :password, :password_confirmation, 
      customer_attributes: [:name, :birthday, :zipcode],
      merchant_attributes: [:store_name, :address, :address2, :city, :state, :zipcode])
    }
  end
  
  def user_update_params
    devise_parameter_sanitizer.sanitize(:account_update) { |u|
      u.permit(:email, :password, :password_confirmation, :current_password, 
      customer_attributes: [:name, :birthday, :zipcode],
      merchant_attributes: [:store_name, :address, :address2, :city, :state, :zipcode])
    }
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(user)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
