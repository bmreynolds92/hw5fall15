# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end


# New step definitions to be completed for HW5. 
# Note that you may need to add additional step definitions beyond these


# Add a declarative step here for populating the DB with movies.

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|

  movies_table.hashes.each do |movie|
    # Each returned movie will be a hash representing one row of the movies_table
    # The keys will be the table headers and the values will be the row contents.
    # Entries can be directly to the database with ActiveRecord methods
    # Add the necessary Active Record call(s) to populate the database.
    Movie.create(movie)
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |rating_list| #this stuff corresponds with "restrict to movies with 'PG' or 'R' ratings" 
  
    rating_list.split(/,\s*/).each do |rating|
      rating = "ratings_#{rating}"
      check(rating)
      
    end
end

When /^I have unchecked the following ratings: "(.*?)"$/ do |rating_list| #this stuff corresponds with "restrict to movies with 'PG' or 'R' ratings" 
    rating_list.split(/,\s*/).each do |rating|
      rating = "ratings_#{rating}"
      uncheck(rating)
    end
end

When /^I have opted to see all movies rated: "(.*?)"$/ do |rating_list| #this stuff corresponds with all ratings "G, PG, PG-13, R, NC-17"
    rating_list.split(/,\s*/).each do |rating|
      rating = "ratings_#{rating}"
      check(rating)
      
    end
end
Then /^I should see only movies rated: "(.*?)"$/ do |rating_list| #this stuff corresponds with "restrict to movies with 'PG' or 'R' ratings" 
    rating_list.split(/,\s*/).each do |rating|
        if page.respond_to? :should
            page.should have_content(rating)
        else
             assert page.has_content?(rating)
         end
    end
end

Then /^I should not see movies rated: "(.*?)"$/ do |rating_list|
      rating_list.split(/,\s*/).each do |rating|
        if page.respond_to? :should
            page.should have_content(rating)
        else
             assert page.has_content?(rating)
         end
    end
end

When /^I unchecked all the following ratings:"(.*?)"$/ do |rating_list|
  rating_list.split(/,\s*/).each do |rating|
      rating = "ratings_#{rating}"
      uncheck(rating)
  end
end

Then /^I should see "(.*?)" of the movies$/ do |arg1|
  rows = page.all("table#movies tr").count
  case arg1
  when "none"
    rows.should == 11
  when "all"
    rows.should == 11
  end
end


#part 3 steps for sort_movie_list.feature
When(/^I examine "(.*?)"$/) do |arg1|
end

Then(/^I should see "(.*?)" before "(.*?)"$/) do |arg1, arg2|
  page.body.should match /#{arg1}.*#{arg2}/m
end

