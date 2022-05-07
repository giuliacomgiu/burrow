# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleController, type: :feature do
  describe 'GET index' do
    it 'links to create person link' do
      create(:person, first_name: 'Abigail')
      create(:person, first_name: 'Margarida')
      visit '/people'
      expect(page).to have_link('Create user', href: new_person_path)
      expect(page).to have_content('Abigail')
      expect(page).to have_content('Margarida')
    end
  end
end
