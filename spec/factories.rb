FactoryGirl.define do
  factory :user do
    email 'alice@example.com'
    password '12345678'
    password_confirmation '12345678'

    factory :user_wrong_confirmation do
      password_confirmation 'wrong'
    end

    factory :user_no_email do
      email ''
    end
  end
end