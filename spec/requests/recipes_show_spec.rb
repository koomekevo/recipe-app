require 'rails_helper'

RSpec.describe 'Recipe Show Page', type: :feature do
  before(:each) do
    visit user_session_path
    @user1 = User.create!(name: 'Tom', email: 'tom@gmail.com', password: 'tom1234')

    fill_in 'Email', with: 'tom@gmail.com'
    fill_in 'Password', with: 'tom1234'
    click_button 'Log in'

    @recipe1 = @user1.recipes.create!(
      name: 'Nshima', preparation_time: 11, cooking_time: 23,
      description: 'cook cook.',
      public: true
    )

    @food1 = @user1.foods.create!(name: 'Apple', price: 4, measurement_unit: 'kg')

    visit recipe_path(@recipe1)
    expect(page).to have_current_path(recipe_path(@recipe1))
  end

  describe 'I can see' do
    it 'a recipe\'s title.' do
      expect(page).to have_content 'Nshima'
    end

    it 'a link to the general shopping list' do
      expect(page).to have_link 'Generate shopping list'
    end

    it 'test clicking the "Generate shopping list" link redirects me to the shopping list.' do
      click_button 'Generate shopping list'
      expect(page).to have_current_path general_shopping_lists_path(@recipe1)
    end
  end
end
