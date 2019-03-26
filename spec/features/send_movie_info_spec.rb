require "rails_helper"
describe "Emails features" do  
  let!(:movies) { create_list(:movie, 1) }
  let!(:user) { FactoryBot.create(:normal_user) }
  it "send movie info" do
    stub_request(:get, "https://pairguru-api.herokuapp.com/api/v1/movies/#{Movie.first.title}").
    with(
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'User-Agent'=>'Ruby'
      }).
    to_return(status: 200, body: "", headers: {})         
    
    login_as(user, :scope => :user)
    # visit "/movies/1"
    # expect(page).to have_selector("h1", text: Movie.first.title)
    # assert_emails 1 do
    #   click_on 'Invite'
    # end
  end
end