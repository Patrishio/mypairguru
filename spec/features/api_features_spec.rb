require "rails_helper"
describe "API features" do  
  let!(:movies) { create_list(:movie, 5) }
  let!(:user) { FactoryBot.create(:normal_user) }
  let!(:enhanced_user) { FactoryBot.create(:enhanced_user) }

  it "send a list of movies (id, title)", type: :request do    
    get "/movies.json"
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(5)
  end  

  it "to not send a movie details if user is no logged in", type: :request do    
    get "/movies/1.json"        
    json = JSON.parse(response.body)    

    expect(response).to_not be_success
  end
  
  it "send a movie details if user is logged in", type: :request do
    login_as(user, :scope => :user)
    get "/movies/1.json"    
    json = JSON.parse(response.body)    
    movie = Movie.first
    
    expect(response).to be_success
    expect(json["data"]).to eq([movie.id, movie.title])
  end

  it "send an enhancedd movie details if enhanced user is logged in", type: :request do
    login_as(enhanced_user, :scope => :user)
    get "/movies/1.json"        
    json = JSON.parse(response.body)        
    movie = Movie.first

    expect(response).to be_success
    expect(json["data"]).to eq([movie.id, movie.title, movie.genre.id, movie.genre.name, movie.genre.movies.count])
  end

end
