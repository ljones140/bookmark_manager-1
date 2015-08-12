FactoryGirl.define do
  factory :user do
    email 'alice@example.com'
    password '12345678'
    password_confirmation '12345678'
  end

  factory :user_wrong_confirmation, class: User do
    email 'alice@example.com'
    password '12345678'
    password_confirmation 'wrong'
  end

  factory :user_no_email, class: User do
    email ''
    password '12345678'
    password_confirmation '12345678'
  end
end