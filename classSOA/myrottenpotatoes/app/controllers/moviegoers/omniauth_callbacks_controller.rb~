class Moviegoers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/moviegoer.rb)
    @moviegoer = Moviegoer.find_for_facebook_oauth(request.env["omniauth.auth"], current_moviegoer)

    if @moviegoer.persisted?
      sign_in_and_redirect @moviegoer, :event => :authentication #this will throw if @moviegoer is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_moviegoer_registration_url
    end
  end
end
