require File.expand_path('../../../test_config', __FILE__)

feature %{
  When I access the main page
  I should see a link
  that takes me to a shorten url link form
} do

  background do
    Capybara.app = Shortener
    visit '/'
  end

  scenario "With the main page, I should see a link to shorten url" do
    find_link('Shorten url!').visible?
  end

  scenario "With shorten url link, the current path should" do
    click_link('Shorten url!')
    current_path
  end.equals "/links/new"

end

