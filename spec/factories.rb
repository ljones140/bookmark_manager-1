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

  factory :link do
    url 'http://www.makersacademy.com'
    title 'Makers Academy'

    factory :link_bubble do
      url 'http://www.bubble-bobble.com'
      title 'Bubble Bobble'
    end

    factory :link_zombo do
      url 'http://www.zombo.com'
      title 'This is Zombocom'
    end
  end


  factory :tag do
      name "education"

    factory :tag_bubble do
      name "bubbles"
    end
  end
end



