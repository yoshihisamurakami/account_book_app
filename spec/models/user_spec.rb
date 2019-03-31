require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(
      name: "Example User",
      email: "user@example.com",
      password: "foobar",
      password_confirmation: "foobar"
    )
  end

  it "名前, email, パスワードがあれば正常な状態であること" do
    expect(@user).to be_valid
  end

  it "名前がなければ異常状態であること" do
    @user.name = nil
    expect(@user).to_not be_valid
    expect(@user.errors[:name]).to include("を入力してください")
  end

  it "emailアドレスがなければエラーになること" do
    @user.email = "  "
    expect(@user).to_not be_valid
    expect(@user.errors[:email]).to include("を入力してください")
  end

  it "名前が長すぎたらエラーになること" do
    @user.name = "a" * 51
    expect(@user).to_not be_valid
  end

  it "emailアドレスが長すぎたらエラーになること" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).to_not be_valid
  end

  it "正常なemailアドレスであること" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address} should be valid"
    end
  end

  it "異常なemailアドレスであること" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end
end
