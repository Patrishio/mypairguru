class EmailMoviesCsv < ProgressJob::Base
    def initialize(current_user, file_path)
      @current_user = current_user
      @file_path = file_path
    end
  
    def perform
      MovieExporter.new.call(@current_user, @file_path)      
    end
  end
  