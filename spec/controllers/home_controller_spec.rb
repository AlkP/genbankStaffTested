require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #show' do
    before do
      # 25.times { UserAction.new() }
      get :show
    end
    
    it "Ответ successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it 'Ренден страницу show' do
      expect(response).to render_template :show
    end
    
    it 'Заполнить массив 15 последних входов пользователей' do
      # expect(assigns(:user_actions)).to match_array(UserAction.first(15))
    end
  end
end