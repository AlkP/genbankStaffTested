require 'rails_helper'

RSpec.describe NomenclaturesController, type: :controller do
  before do
    Role.create!(FactoryGirl.attributes_for(:admin_role))
    Role.create!(FactoryGirl.attributes_for(:manager_role))
    Role.create!(FactoryGirl.attributes_for(:user_role))
    Nomenclature.create!(FactoryGirl.attributes_for(:parent_nomenclature))
    25.times { Nomenclature.new(title: rand(10**10).to_i.to_s) }
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
  
  describe 'GET #index from guest' do
    before do
      get :index
    end

    it 'Заполнить массив объектов первых 15 записей' do
      expect(assigns(:nomenclatures)).to_not match_array(Nomenclature.first(15))
    end

    it 'Ренден страницу index' do
      expect(response).to redirect_to '/users/sign_in'
    end
  end
  
  describe 'GET #index from admin' do
    before do
      sign_in FactoryGirl.create(:admin), scope: :admin
      
      # admin = FactoryGirl.create(:admin)
      # sign_in admin
      
      # sign_in users(:admin), scope: :admin
      
      get :index
    end

    it 'Заполнить массив объектов первых 15 записей' do
      expect(assigns(nomenclatures)).to match_array(Nomenclature.first(15))
    end

    it 'Ренден страницу index' do
      expect(response).to render_template :index
    end
  end
end
