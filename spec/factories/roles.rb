FactoryGirl.define do
  factory :admin_role, class: Role do
    name 'admin'
  end
  factory :manager_role, class: Role do
    name 'manager'
  end
  factory :user_role, class: Role do
    name 'user'
  end
  factory :role_invalid, class: Role do
    name 'qwe'
  end
  factory :role_null, class: Role do
    name ''
  end
end
