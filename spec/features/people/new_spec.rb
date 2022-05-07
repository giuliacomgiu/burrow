# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleController, type: :feature do
  describe 'GET new' do
    it 'has correct form' do
      visit '/people/new'
      fill_in 'First name', with: 'Odésia'
      fill_in 'Last name', with: 'Carvalho'
      click_button 'Salvar'
      expect(page).to have_current_path(people_path)
    end
  end
end
