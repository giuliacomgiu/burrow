# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleController, type: :feature do
  describe 'GET people/id' do
    it 'has correct form' do
      person = create(:person)
      visit "/people/#{person.id}"
      expect(page).to have_content person.first_name
      expect(page).to have_content person.last_name
    end
  end
end
