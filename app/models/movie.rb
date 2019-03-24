# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre

  def movie_data
    GetMovieData.new(self.title)    
  end  

  def self.name_and_title
    self.pluck(:id, :title)
  end

  def normal_movie_export_data
    [self.id, self.title]
  end

  def enhanced_movie_export_data
    [self.id, self.title, self.genre.id, self.genre.name, self.genre.movies.count]
  end

  def movie_export_data(enhanced_user)
    return self.enhanced_movie_export_data if enhanced_user
    normal_movie_export_data
  end

end
