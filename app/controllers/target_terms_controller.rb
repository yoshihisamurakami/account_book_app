class TargetTermsController < ApplicationController
  before_action :initialize_session, only: [:prev, :next]

  def initialize_session
    target_term = TargetTermModel.new(session)
    session[:target_term_year]  ||= target_term.year
    session[:target_term_month] ||= target_term.month
  end

  def prev
    date = Date.new(session[:target_term_year], session[:target_term_month], 1)
    prev_month_day = date.prev_month(1)
    session[:target_term_year]  = prev_month_day.year
    session[:target_term_month] = prev_month_day.month
    render json: { status: 'ok' }
  end

  def next
    date = Date.new(session[:target_term_year], session[:target_term_month], 1)
    next_month_day = date.next_month(1)
    session[:target_term_year]  = next_month_day.year
    session[:target_term_month] = next_month_day.month
    render json: { status: 'ok' }
  end

end