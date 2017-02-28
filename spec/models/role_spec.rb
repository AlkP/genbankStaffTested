require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'Проверка наличия имени' do
    expect(Role.new(FactoryGirl.attributes_for(:role_null))).to_not be_valid
  end
  it 'Проверка уникальности имени' do
    Role.create!(FactoryGirl.attributes_for(:admin_role))
    expect(Role.new(FactoryGirl.attributes_for(:admin_role))).to_not be_valid
  end
  it 'Длина имени более 4 символов' do
    expect(Role.new(FactoryGirl.attributes_for(:role_invalid))).to_not be_valid
  end
end
