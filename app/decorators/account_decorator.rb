class AccountDecorator < Draper::Decorator
  delegate_all

  def balance
    object.balance.to_s(:delimited)
  end

end
