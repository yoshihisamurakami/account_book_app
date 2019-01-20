ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # テストユーザーとしてログインする
  def log_in_as(user)
    session[:user_id] = user.id
  end

  # book オブジェクトからPOST用パラメータを返す
  def parameter_to_post(book)
    { book: {
      books_date: book.books_date,
      user_id: book.user_id,
      account_id: book.account_id,
      deposit: book.deposit,
      transfer: book.transfer,
      category_id: book.category_id,
      summary: book.summary,
      amount: book.amount,
      common: book.common,
      business: book.business,
      special: book.special,
      }
    }
  end
end

class ActionDispatch::IntegrationTest

  # テストユーザーとしてログインする
  def log_in_as(user, password: 'password')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                              } }
  end
end
