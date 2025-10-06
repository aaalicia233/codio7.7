# Add a declarative step here for populating the DB with movies.

Given /the following movies exist:/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then(/(.*) seed movies should exist/) do |n_seeds|
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.index(e1)).to be < page.body.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I check the following ratings: (.*)/ do |rating_list|
  rating_list.split(', ').each do |rating|
    check("ratings[#{rating}]")
  end
end

# Part 2, Step 3
Then(/^I should (not )?see the following movies: (.*)$/) do |should_not, movie_list|
    movies = movie_list.split(', ')
    movies.each do |movie|
      if should_not
        expect(page).not_to have_content(movie)
      else
        expect(page).to have_content(movie)
      end
    end
  end

Then /I should see all the movies/ do
  rows = page.all('table#movies tr').size - 1 # -1 是因为要去掉表头那一行
  expect(rows).to eq Movie.count
end

### Utility Steps Just for this assignment.

Then(/^debug$/) do
  # Use this to write "Then debug" in your scenario to open a console.
  require "byebug"
  byebug
  1 # intentionally force debugger context in this method
end

Then(/^debug javascript$/) do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end

Then(/complete the rest of of this scenario/) do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  raise "Remove this step from your .feature files"
end
