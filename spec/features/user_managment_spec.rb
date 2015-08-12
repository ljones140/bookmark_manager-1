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
    expect(page).to have_content 'Please refer to the following errors below: Password does not match the confirmation'
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


  def sign_up_as(user)
    visit '/users/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    fill_in :password_confirmation, with: user.password_confirmation
    click_button 'Sign up'
  end
end

