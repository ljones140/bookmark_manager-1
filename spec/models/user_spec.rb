require 'spec_helper'

describe User do

  let(:user) { create(:user) }

  it 'authenticated when given a valid email and password' do
    authenticated_user = User.authenticate(user.email, user.password)
    expect(authenticated_user).to eq(user)
  end

  it 'does not authenticate incorrect password' do
    expect(User.authenticate(user.email, "incorrect_password")).to be_nil
  end
end