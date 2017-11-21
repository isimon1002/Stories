class GenresController < ApplicationController
   def index
     @genre = Genre.all
   end
   
   def show
     @genre = Genre.find(params[:id])
   end
end
