class AccountDecorator < Draper::Decorator
  delegate_all

  def balance
    object.balance.to_formatted_s(:delimited)
  end

end
