require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'GET /login' do
    it 'http status 200を返すこと' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /login' do
    let!(:user) { create(:user) }
    context 'ユーザー名とパスワードが正しい場合' do
      let(:params) { 
        { 
          session: {
            email: 'testuser1@example.com',
            password: 'password'
          }
        }
      }
      it 'root_urlにリダイレクトされること' do
        post login_path, params: params
        expect(response).to redirect_to(root_url)
      end
      # request specではなく log_inメソッドのテストに書くべき内容かも
      it 'sessionに値がセットされること' do
        post login_path, params: params
        expect(session[:user_id]).to eq user.id
      end
    end
    context 'ユーザー名とパスワードが間違っていた場合' do
      let(:params) { 
        { 
          session: {
            email: 'testuser1@example.com',
            password: 'hogehoge'
          }
        }
      }
      it 'http status 200を返すこと' do
        post login_path, params: params
        expect(response).to have_http_status(:success)
      end
      it 'エラーメッセージを返すこと' do
        post login_path, params: params
        expect(response.body).to include 'メールアドレスとパスワードの組み合わせが正しくありません'
      end
    end
  end
  describe 'DELETE /logout' do
    it 'root_urlにリダイレクトされること' do
      delete logout_path
      expect(response).to redirect_to(root_url)
    end
  end
end