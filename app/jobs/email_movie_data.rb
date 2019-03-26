class EmailMovieData < ProgressJob::Base
  def initialize(current_user, movie)
    @movie = movie
    @current_user = current_user
  end

  def perform
    MovieInfoMailer.send_info(@current_user, @movie).deliver_now
  end
end
