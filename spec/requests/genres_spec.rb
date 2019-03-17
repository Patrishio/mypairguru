require "rails_helper"

describe "Genres requests", type: :request do
  let!(:genres) { create_list(:genre, 5, :with_movies) }

  describe "genre list" do
    it "displays only related movies" do
      genres.each do |genre| 
        genre.movies.each do |movie|
          stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/#{movie.title}").
          with(
            headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent'=>'Ruby'
            }).
          to_return(status: 200, body: "", headers: {})          
        end
      end

      visit "/genres/" + genres.sample.id.to_s + "/movies"
      expect(page).to have_selector("table tr", count: 5)
    end
  end
end
