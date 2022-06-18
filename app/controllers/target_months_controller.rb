class TargetMonthsController < ApplicationController

  def prev
    target_month.move_to_prev_month!
    render json: { status: 'ok' }
  end

  def next
    target_month.move_to_next_month!
    render json: { status: 'ok' }
  end

  private

  def target_month
    @target_month ||= TargetMonth.new(session)
  end
end