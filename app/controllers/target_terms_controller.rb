class TargetTermsController < ApplicationController
  before_action :initialize_session, only: [:prev, :next]

  def initialize_session
    target_term = TargetTermModel.new(session)
    session[:target_term_year]  ||= target_term.year
    session[:target_term_month] ||= target_term.month
  end

  def prev
    update_target_term 'prev'
  end

  def next
    update_target_term 'next'
  end

  private

  def update_target_term(target)
    date = Date.new(session[:target_term_year], session[:target_term_month], 1)
    target_month_day = date.send(target + '_month')
    session[:target_term_year]  = target_month_day.year
    session[:target_term_month] = target_month_day.month
    render json: { status: 'ok' }
  end

end