require "rails_helper"
describe "API features" do  
  let!(:movies) { create_list(:movie, 5) }
  it "send a list of movies (id, title)", type: :request do
    get "/movies.json"
    json = JSON.parse(response.body)

    expect(response).to be_success
    expect(json['data'].length).to eq(5)
  end  
end
