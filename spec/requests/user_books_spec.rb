require 'rails_helper'

RSpec.describe 'UserBooks', type: :request do
  describe 'GET /user/:id/books' do
    let!(:user) { create(:user) }
    context 'ログインしていない場合' do
      it 'リダイレクトされること' do
        get user_books_path(user.id)
        expect(response).to redirect_to(login_url)
      end
    end
    context 'ログインしているとき' do
      before do
        log_in_as(user)
      end
      it 'http status 200を返すこと' do
        get user_books_path(user.id)
        expect(response).to have_http_status(:success)
      end
    end
  end
end