require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #show' do
    before do
      # 25.times { UserAction.new() }
      get :show
    end
    
    it 'Заполнить массив 15 последних входов пользователей' do
      # expect(assigns(:user_actions)).to match_array(UserAction.first(15))
    end

    it 'Ренден страницу show' do
      expect(response).to render_template :show
    end
  end
end