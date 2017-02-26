# frozen_string_literal: true
class ApplicationController < ActionController::API
  include Pundit

  if Rails.env.development? || Rails.env.test?
    after_action :verify_authorized
    after_action :verify_policy_scoped, except: :create
  end

  rescue_from Pundit::NotAuthorizedError do
    head current_user.nil? ? :unauthorized : :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: { errors: { error.model => ['not found'] } }, status: :not_found
  end

  rescue_from ActiveRecord::RecordInvalid,
              ActiveRecord::RecordNotSaved,
              ActiveRecord::RecordNotDestroyed do |error|
    render json: { errors: error.record.errors }, status: :unprocessable_entity
  end

protected

  def authorize_user!
    raise Pundit::NotAuthorizedError, 'must be logged in' if current_session.nil?
  end

  def current_session
    return @current_session if defined?(@current_session) || session_token.blank?
    @current_session = Session.active.find_by(id: session_token)
  end

  def current_user
    current_session&.user
  end

  def meta_for(relation)
    { page:  relation.current_page,
      prev:  relation.prev_page,
      next:  relation.next_page,
      total: relation.total_count,
      pages: relation.total_pages }
  end

  def session_token
    request.headers['Session-Token'].presence || params[:session_token]
  end
end
