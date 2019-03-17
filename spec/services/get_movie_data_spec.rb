require "rails_helper"

describe "Get movie data" do 
  let(:action) { GetMovieData.new("Godfather") }
  let(:json_body) {
    (
      {"data":
        {"id":"6",
        "type":"movie",
        "attributes":{
          "title":"Godfather",
          "plot":"The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
          "rating":9.2,"poster":"/godfather.jpg"
        }
      }
      }
    ).to_json}
  
  # --------------------------------------------------------
  it "returns proper action rating" do

    stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: json_body, headers: {})
    
    expect(action.rating).to eq(9.2) 

  end    

  # --------------------------------------------------------
  it "returns proper action plot" do

    stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: json_body, headers: {})    
    
    expect(action.plot).to eq("The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.")   
  end    
  
  # --------------------------------------------------------
  it "returns proper action poster" do  

    stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: json_body, headers: {})        
    
    expect(action.poster).to eq("https://pairguru-api.herokuapp.com/godfather.jpg")
  end      
end