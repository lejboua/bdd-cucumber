# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(:title => movie[:title], :rating => movie[:rating], :release_date => movie[:release_date])
  end
  # flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  movie_rows = page.find('table#movies tbody').all('tr')
  # first <td> is the title
  movie_titles = movie_rows.map { |tr| tr.all('td').first.text }
  e1_pos = movie_titles.index e1
  e2_pos = movie_titles.index e2
  e1_pos.should < e2_pos
  # flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  rating_array = rating_list.split(',').each { |r| r.strip! }

  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # debugger
  rating_array.each { |r| 
    if (uncheck)
      step %Q{I uncheck "ratings[#{r}]"}
      # uncheck(r)
    else
      step %Q{I check "ratings[#{r}]"}
      # check(r)
    end
  }
  # flunk "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  rows_count = page.find('table#movies tbody').all('tr').count
  rows_count.should == Movie.count
  # assert_equal rows_count, Movie.count
  # flunk "Unimplemented"
end
