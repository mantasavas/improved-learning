class CallbacksController < ApplicationController

	def google_oauth2
		@user = User.from_omniauth(request.env["omniauth.auth"])
		#devise method
		#binding.pry
		sign_in_and_redirect @user
	end


end
