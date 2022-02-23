class TaxSummariesController < ApplicationController
  before_action :require_logged_in, only: [:index]
  include StaticPageActions

  # MEMO:
  # この機能はカテゴリID
  #  27: 会議費
  #  28: 消耗品費
  #  29: 福利厚生費
  # がデータに追加されている前提

  APPORTIONMENT_TABLE = [
    {category_id: 27, division: 1},  # 会議費
    {category_id: 21, division: 1},  # 交際費
    {category_id: 19, division: 0.8},  # 交通費
    {category_id: 23, division: 1},  # 雑費
    {category_id: 13, division: 1},  # 書籍代
    {category_id: 28, division: 1},  # 消耗品費
    {category_id: 9,  division: 0.6},  # 水道光熱費
    {category_id: 12, division: 0.6},  # 賃貸代
    {category_id: 11, division: 0.8},  # 通信費
    {category_id: 29, division: 1},  # 福利厚生費
  ]

  def index
    target_term = TargetTermModel.new(session)
    books = Book
      .target_year(target_term.year)
      .payments
      .business
      .without_transfer
      .group(:category_id)
      .order(category_id: :asc)
      .sum(:amount)
    @summaries = get_summaries(books)
  end

  private

  def get_summaries(books)
    summaries = []
    books.each do |info|
      category_id = info[0]
      category_name = Category.find(category_id).name
      amount = info[1]
      summaries << {
        category_id: category_id,
        category_name: category_name,
        amount: amount,
        division: apportionment(category_id),
        result_amount: (amount * apportionment(category_id)).to_i
      }
    end
    summaries
  end

  # カテゴリID別 按分
  def apportionment(category_id)
    selected = APPORTIONMENT_TABLE.select do |tbl|
      tbl[:category_id] == category_id
    end
    if selected.count == 1
      selected.first[:division]
    else
      0
    end
  end
end
