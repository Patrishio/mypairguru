require "rails_helper"
describe "API features" do  
  let!(:movies) { create_list(:movie, 5) }
  let!(:user) { FactoryBot.create(:user) }

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

    expect(response).to be_success
  end

end
