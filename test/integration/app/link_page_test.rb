require File.expand_path('../../../test_config', __FILE__)

feature %{
  When I access the link pages
  I should see a form
  that allows me to shorten urls
} do

  background do
    Capybara.app = Shortener
    visit '/links/new'
  end

  scenario "With the links page, I should see a text field" do
    find_field('Url').visible?
  end

  scenario "With the links page, I should be able to submit a url" do
    fill_in 'Url', :with => 'http://www.google.com'
    click_button 'Submit'
    current_path
  end.matches %r{links\/show}

end


