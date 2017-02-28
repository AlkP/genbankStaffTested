require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  before do
    Role.create!(FactoryGirl.attributes_for(:admin_role))
    Role.create!(FactoryGirl.attributes_for(:manager_role))
    Role.create!(FactoryGirl.attributes_for(:user_role))
    15.times { Role.new(name: rand(10**10).to_i.to_s) }
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
  
  describe 'GET #index from guest' do
    before do
      get :index
    end

    it 'Заполнить массив объектов первых 7 записей' do
      expect(assigns(:roles)).to_not match_array(Role.first(7))
    end

    it 'Ренден страницу index' do
      expect(response).to redirect_to '/users/sign_in'
    end
  end
  
  describe 'GET #index from admin' do
    before do
      sign_in FactoryGirl.create(:admin)
      get :index
    end

    it 'Заполнить массив объектов первых 7 записей' do
      expect(assigns(:roles)).to match_array(Role.first(7))
    end

    it 'Ренден страницу index' do
      expect(response).to render_template :index
    end
  end
end
