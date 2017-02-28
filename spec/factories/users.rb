FactoryGirl.define do
  factory :admin, class: User do
    username 'admin'
    role_id 1
    password 'admin'
    password_confirmation 'admin'
  end
end
