class GetMovieData
    attr_reader :movie_name 
  
    def initialize(movie_name)
      @movie_name = movie_name
      @movie_data = self.get_movie_data
    end
  
    def get_movie_data 
      uri = URI("https://pairguru-api.herokuapp.com/api/v1/movies/#{URI.encode(@movie_name)}")      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)  
      JSON.parse(response.body) if response.body.present?
    end
  
    def rating      
      @movie_data["data"]["attributes"]["rating"] if @movie_data.present?
    end
  
    def plot
      @movie_data["data"]["attributes"]["plot"] if @movie_data.present?
    end
  
    def poster
      "https://pairguru-api.herokuapp.com#{@movie_data["data"]["attributes"]["poster"]}" if @movie_data.present?
    end
  end