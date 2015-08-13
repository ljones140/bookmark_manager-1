require 'spec_helper'

feature 'User sign up' do

  let!(:user) { build(:user) }

  let(:user_wrong_confirmation) { build(:user_wrong_confirmation) }
  let(:user_no_email) { build(:user_no_email) }


  scenario 'I can sign up as a new user' do

    expect { sign_up_as(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do

    expect { sign_up_as(user_wrong_confirmation) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'requires an email' do

    expect { sign_up_as(user_no_email) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Please refer to the following errors below: Email must not be blank'
  end

  scenario 'I cannot sign up with an exisiting email' do
    user_new = create(:user)
    sign_up_as(user)
    expect { sign_up_as(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end
end


feature 'User sign in' do

  let(:user) { create(:user) }

  scenario 'with correct credentials' do
    sign_in_as(user)
    expect(page).to have_content "Welcome, #{user.email}"
  end
end

feature 'User signs out' do

  let(:user) { create(:user) }

  scenario 'while being signed in' do
    sign_in_as(user)
    click_button 'Sign out'
    expect(page). to have_content('goodbye!')
    expect(page).not_to have_content('Welcome, alice@example.com')
  end
end



