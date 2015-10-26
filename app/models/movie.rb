class Movie < ActiveRecord::Base
  
  class Movie::InvalidKeyError < StandardError ; end
    
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def name_with_rating
    "#{self.title} (#{self.rating})"
  end
  
  def self.api_key
    "f4702b08c0ac6ea5b51425788bb26562"
  end
  
  def self.find_in_tmdb(string)
    Tmdb::Api.key(self.api_key)
    begin
      Tmdb::Movie.find(string)
    rescue NoMethodError => tmdb_gem_exception
      if Tmdb::Api.response["code"] == 401
        raise Movie::InvalidKeyError, 'Invalid API key'
      else
        raise tmdb_gem_exception
      end
    end
    #result = Tmdb::Movie.find(string)
    #Convert the array of Movie objects into an array of hashes
    #hashed_result = Hash[result.map {|key, value| [key, value]}]
    #return hashed_result
  end
end

