# in spec/models/movie_spec.rb
require 'spec_helper.rb'
require 'rails_helper'
require "rspec/expectations"
require "rspec/its"
require "themoviedb"

describe Movie do
  it 'should include rating and year in full name' do
    # 'build' creates but doesn't save object; 'create' also saves it
    movie = FactoryGirl.build(:movie, :title => 'Milk', :rating => 'R')
    expect(movie.name_with_rating).to eq('Milk (R)')
  end
  
  describe "searching Tmdb by keyword" do
    context "with valid key" do
	    it "should call Tmdb with title keywords" do
	      expect(Tmdb::Movie).to receive(:find).with("Inception")
		    Movie.find_in_tmdb("Inception")
	    end
	  end

	  context "with invalid key" do
	    it "should raise InvalidKeyError if key is missing or invalid" do
	      allow(Tmdb::Movie).to receive(:find).and_raise(NoMethodError)
		    allow(Tmdb::Api).to receive(:response).and_return({'code' => 401})
		    expect{Movie.find_in_tmdb("Inception")}.to raise_error(Movie::InvalidKeyError)
	    end
	  end
  end
end

