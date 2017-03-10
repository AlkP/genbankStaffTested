require 'rails_helper'

RSpec.describe Nomenclature, type: :model do
  it 'Проверка наличия имени' do
    expect(Nomenclature.new(FactoryGirl.attributes_for(:nomenclature_null))).to_not be_valid
  end
  it 'Длина имени более 6 символов' do
    expect(Nomenclature.new(FactoryGirl.attributes_for(:nomenclature_invalid))).to_not be_valid
  end
end
