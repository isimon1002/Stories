class ProfileController < ApplicationController
    def show
        @user = User.find(params[:id])
        @genre = Genre.find(params[:id])
    end
end
