require_relative 'acceptance_helper'

feature 'User answer', %q{
 In order to exchange my knowledge
 As an authenticated user
 I want to be able to post answers
} do

  given(:user) { create(:user)}
  given!(:question) { create(:question) }

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    expect(current_path).to eq question_path(question)
    # Пофиксить, ошибка:
    # Capybara::ElementNotFound:
    #        Unable to find visible css ".answers"

    within '.answer' do
      save_and_open_page
      expect(page).to have_content 'My answer'
    end
  end

  scenario 'User is trying to create invalid answer', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Create'

    expect(page). to have_content "Answer's body can't be blank"
  end
end