class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  has_many :books
  
  # 渡された文字列のハッシュ値を返す  fixture向け
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ユーザー別の家計簿一覧
  def books_list(target_month:, page:)
    self.books.target_month_and_page(
      target_month: target_month,
      page: page
    )
  end
end
