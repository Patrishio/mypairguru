class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  before_action :authenticate_user!, only: [:show], if: :format_json?


  def index
    @movies = Movie.all.decorate
    
    respond_to do |format|
      format.html
      format.json { 
        @jmovies = Movie.name_and_title
        render json: 
        {
          status: 'SUCCESS',           
          data: @jmovies
        }, 
        status: :ok 
      }
    end
  end

  def show
    @movie = Movie.find(params[:id])
    
    respond_to do |format|
      format.html {
        @movie_data = @movie.movie_data
      }
      format.json {   
        render json:
        {
          status: 'SUCCESS',
          data: @movie.movie_export_data(current_user.enhanced)
        },
        status: :ok
      }
    end
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end

def format_json?
  request.format.json?
end