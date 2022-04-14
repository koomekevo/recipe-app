require 'rails_helper'

RSpec.describe 'Recipe Index Page', type: :feature do
  before(:each) do
    visit user_session_path
    @user1 = User.create!(name: 'Tom', email: 'tom@gmail.com', password: 'tom1234')

    fill_in 'Email', with: 'tom@gmail.com'
    fill_in 'Password', with: 'tom1234'
    click_button 'Log in'

    @recipe1 = @user1.recipes.create!(
      name: 'Nshima', preparation_time: 11, cooking_time: 23,
      description: 'food food.',
      public: true
    )
    visit recipes_path
  end

  describe 'I can see' do
    it 'An Title:' do
      expect(page).to have_content 'My list of Recipes'
    end

    it 'a recipe\'s title.' do
      expect(page).to have_content 'Nshima'
    end

    it 'a recipe\'s description' do
      expect(page).to have_content 'food food.'
    end

    it 'When I click to Delete  button' do
      click_button 'Delete'
      expect(page).to have_current_path recipes_path
    end

    it 'When I click to Add a new recipe  button' do
      click_button 'Add a new recipe'
      expect(page).to have_current_path new_recipe_path
    end

    it 'When I click Delete button, it redirects me to the user\'s post\'s index page.' do
      click_button 'Delete'
      expect(page).to have_current_path recipes_path
    end

    it 'when I click on a recipe, it redirects me to that recipe\'s show page.' do
      click_link 'Nshima'
      expect(page).to have_current_path(recipe_path(@recipe1))
    end
  end
end
