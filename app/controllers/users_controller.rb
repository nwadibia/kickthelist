class UsersController < ApplicationController
	def show
  @user = User.find(params[:id])
	end
	
	def ultimate_user_list
	@user = User.order("created_at DESC")
	end
end