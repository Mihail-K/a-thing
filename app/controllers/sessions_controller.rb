# frozen_string_literal: true
class SessionsController < ApplicationController
  before_action :authorize_user!, except: :create
  before_action :set_session, except: :create

  def show
    render json: authorize(@session)
  end

  def create
    @session = Session.new(permitted_attributes(Session)) do |session|
      session.ip        = request.ip
      session.remote_ip = request.remote_ip
    end
    authorize(@session).save!

    render json: authorize(@session), status: :created
  end

  def destroy
    authorize(@session).update!(active: false)
  end

private

  def set_session
    @session = policy_scope(Session).find(params[:id])
  end
end
