require 'rails_helper'

RSpec.feature 'food index page', js: true, type: :feature do
  background do
    visit user_session_path
    @user1 = User.create!(name: 'jake', email: 'jake@gmail.com', password: 'password1')
    fill_in 'Email', with: 'jake@gmail.com'
    fill_in 'Password', with: 'password1'
    click_button 'Log in'

    visit foods_path

    click_button 'Add Food'

    visit new_food_path

    @food1 = @user1.foods.create!(name: 'Orange', price: 10, measurement_unit: 'unit')

    click_button 'submit'

    visit foods_path
  end

  it 'should include the added food' do
    expect(page).to have_content 'Orange'
    expect(page).to have_content 10
    expect(page).to have_content 'unit'
  end
end
